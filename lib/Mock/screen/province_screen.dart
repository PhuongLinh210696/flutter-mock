import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Mock/screen/detail_screen.dart';
import 'package:myapp/Mock/components/dropdownbutton.dart';
import 'package:myapp/Mock/province.dart';
import 'package:myapp/Mock/SQLHelper/sql_helper.dart';


class ProvinceScreen extends StatelessWidget {
  const ProvinceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _ProvincePage(),
    );
  }
}

class _ProvincePage extends StatefulWidget {
  const _ProvincePage();

  @override
  State<StatefulWidget> createState() => _ProvincePageState();
}

class _ProvincePageState extends State<_ProvincePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  //All province
  List<Map<String, dynamic>> _provinceItems = [];
  List<Map<String, dynamic>> _suggestedProvinces = [];
  bool _isLoading = true;
  User? user;
  String dbPath ='';
  // This function is used to fetch all data from the database
  Future<void> _refreshItems() async {
    //Get all item province
    final data = await SQLHelper.getItemsProvince();
    setState(() {
      _provinceItems = data;
      _suggestedProvinces = _provinceItems;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _refreshItems(); // Loading the diary when the app starts
  }

  final TextEditingController _provinceNameController = TextEditingController();
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingItem =
          _provinceItems.firstWhere((element) => element['id'] == id);
      _provinceNameController.text = existingItem['provinceName'];
    } else {
      _provinceNameController.text = '';
    }
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true, // fix pixel overflowed
// builder: (_, counter, __) => Translations(counter.value), // means you have 3 parameters _, counter and __,
// and only counter is what you are using,
// so 1st and 3rd parameters are denoted with _ and __. // This is just cleaner way to write code.
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
// this will prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    controller: _provinceNameController,
                    decoration:
                        const InputDecoration(hintText: 'Province Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
// Save new item
                      if (id == null) {
                        await _addItemProvince();
                      } else {
                        await _updateItemProvince(id);
                      }
// Clear the text fields
                      _provinceNameController.text = '';
// Close the bottom sheet
// if you're not sure your widget is mounted.
// https://www.educative.io/answers/what-is-buildcontext-in-flutter)
                      if (!mounted) return;
                      Navigator.of(context).pop();
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }

  //Show detail
  void _showDetail(int id, String provinceName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailScreen(proId: id, provinceName: provinceName),
        settings: RouteSettings(arguments: id),
      ),
    );
  }

  // Insert a new item to the database
  Future<void> _addItemProvince() async {
    await SQLHelper.createProvince(
        Province(provinceName: _provinceNameController.text));
    _refreshItems();
  }

  // Update an existing item
  Future<void> _updateItemProvince(int id) async {
    await SQLHelper.updateItemProvince(
        Province(provinceId: id, provinceName: _provinceNameController.text));
    _refreshItems();
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        
        actions: [
          //IconButton(onPressed: signOut, icon: const Icon(Icons.logout)),
          DropdownButtonEx(
            user: user,
          )
        ],
        title: const Text('Provinces Page'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: TextField(
              controller: inputController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Province Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),
              onChanged: searchProvince,
            ),
          ),
          Expanded(child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
            itemCount: _suggestedProvinces.length,
            itemBuilder: (context, index) => Card(
              color: Colors.blueGrey[200],
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text(_suggestedProvinces[index]['provinceName']),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        //Detail
                        IconButton(
                            onPressed: () => _showDetail(
                                _suggestedProvinces[index]['provinceId'],
                                _suggestedProvinces[index]['provinceName']),
                            icon:
                                const Icon(Icons.arrow_circle_right_outlined)),
                        //Edit
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              _showForm(_suggestedProvinces[index]['provinceId']),
                        ),
                        //IconButton(
                        //Delete
                        //  icon: const Icon(Icons.delete),
                        //  onPressed: () => _deleteItem(_items[index]['id']),
                        //)
                      ],
                    ),
                  ),
                ),
            ),
          )
          ),
        ],
      ),
            
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
  void searchProvince(String query){
    if(query.isEmpty){
      _suggestedProvinces = List.from(_provinceItems);
    }else{
      final suggest = _provinceItems
        .where((province) =>
            province['provinceName'].toLowerCase().contains(query.toLowerCase()))
        .toList();

         setState(() {
          _suggestedProvinces = suggest;
        });
    }
  }
  
  
  }
