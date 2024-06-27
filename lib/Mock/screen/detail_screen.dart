import 'package:flutter/material.dart';
import 'package:myapp/Mock/SQLHelper/city.dart';
import 'package:myapp/Mock/SQLHelper/licenseplate.dart';
import 'package:myapp/Mock/SQLHelper/scinecspot.dart';
import 'package:myapp/Mock/SQLHelper/sql_helper.dart';
import 'package:myapp/Mock/SQLHelper/university.dart';
import 'package:myapp/Mock/screen/city_detai_screen.dart';

class DetailScreen extends StatelessWidget {
  final int? proId;
  final String? provinceName;
  const DetailScreen(
      {super.key, required this.proId, required this.provinceName});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _DetailPage(
        proId: proId,
        provinceName: provinceName,
      ),
    );
  }
}

class _DetailPage extends StatefulWidget {
  final int? proId;
  final String? provinceName;
  const _DetailPage(
      {super.key, required this.proId, required this.provinceName});
  @override
  State<StatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends State<_DetailPage> {
  //All city by province id
  List<Map<String, dynamic>> _cityItems = [];
  //All licp by province id
  List<Map<String, dynamic>> _licpItems = [];
  //All scinecspots by province id
  List<Map<String,dynamic>> _ssItems = [];
  //All unversities by province id
  List<Map<String,dynamic>> _unItems = [];

  bool _isLoading = true;
  bool _showAdditionalButtons = false;
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _licpNumController = TextEditingController();
  final TextEditingController _ssNameController = TextEditingController();
  final TextEditingController _unNameController =TextEditingController();
  void _toggleAdditionalButtons() {
    setState(() {
      _showAdditionalButtons = !_showAdditionalButtons;
    });
  }

  Future<void> _refreshItemsCity() async {
    final dataCity = await SQLHelper.getItemCitybyProId(widget.proId);
    setState(() {
      _cityItems = dataCity;
      _isLoading = false;
    });
  }

  Future<void> _refreshItemsLicp() async {
    final dataLicp = await SQLHelper.getItemLicensePlateByProId(widget.proId);
    setState(() {
      _licpItems = dataLicp;
      _isLoading = false;
    });
  }

  Future<void> _refreshItemsSS() async{
    final dataSS = await SQLHelper.getItemSsByProId(widget.proId);
    setState(() {
      _ssItems = dataSS;
      _isLoading = false;
    });
  }

  Future<void> _refreshItemsUN() async{
    final dataUn = await SQLHelper.getItemUniByProId(widget.proId);
    setState(() {
      _unItems = dataUn;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    //user = FirebaseAuth.instance.currentUser;
    _refreshItemsCity();
    _refreshItemsLicp(); 
    _refreshItemsSS();
    _refreshItemsUN();// Loading the diary when the app starts
  }

  void _showFormUpdateCity(int? id) {
    //Kiem tra List cityItems co gai tri hay khong
    if (id != null && _cityItems.isNotEmpty) {
      final existingItem =
          _cityItems.firstWhere((element) => element['cityId'] == id);
      _cityNameController.text = existingItem['cityName'];
    } else {
      _cityNameController.text = '';
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
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
                    controller: _cityNameController,
                    decoration: const InputDecoration(hintText: 'City Name'),
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
                        await _addCityName();
                      } else {
                        await _updateItemCity(id);
                      }
// Clear the text fields
                      _cityNameController.text = '';
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

  void _showFormAddCity() async {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
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
                    controller: _cityNameController,
                    decoration: const InputDecoration(hintText: 'City Name'),
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

                      await _addCityName();
// Clear the text fields
                      _cityNameController.text = '';
// Close the bottom sheet
// if you're not sure your widget is mounted.
// https://www.educative.io/answers/what-is-buildcontext-in-flutter)
                      if (!mounted) return;
                      Navigator.of(context).pop();
                    },
                    child: const Text('Create New'),
                  )
                ],
              ),
            ));
  }

  Future<void> _addCityName() async {
    await SQLHelper.createCity(
        City(cityName: _cityNameController.text, provinceId: widget.proId));
    _refreshItemsCity();
  }

  Future<void> _updateItemCity(int id) async {
    await SQLHelper.updateItemCity(City(
        cityId: id,
        cityName: _cityNameController.text,
        provinceId: widget.proId));
    _refreshItemsCity();
  }

  Future<void> _deleteCity(int id) async {
    await SQLHelper.deleteItemCity(id);
    _refreshItemsCity();
  }

  void _showFormAddLicp() {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
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
                    controller: _licpNumController,
                    decoration: const InputDecoration(hintText: 'Licp Num'),
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

                      await _addLicpNum();
// Clear the text fields
                      _licpNumController.text = '';
// Close the bottom sheet
// if you're not sure your widget is mounted.
// https://www.educative.io/answers/what-is-buildcontext-in-flutter)
                      if (!mounted) return;
                      Navigator.of(context).pop();
                    },
                    child: const Text('Create New'),
                  )
                ],
              ),
            ));
  }

  Future<void> _updateItemLicpNum(int id) async {
    await SQLHelper.updateItemLicensePlate(Licenseplate(
        licpId: id,
        licpNum: int.parse(_licpNumController.text),
        provinceId: widget.proId));
    _refreshItemsLicp();
  }

  void _showFormUpdateLicp(int? id) {
    //Kiem tra List cityItems co gai tri hay khong
    if (id != null && _licpItems.isNotEmpty) {
      final existingItem =
          _licpItems.firstWhere((element) => element['licpId'] == id);
      _licpNumController.text = existingItem['licpNum'];
    } else {
      _cityNameController.text = '';
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
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
                    controller: _licpNumController,
                    decoration:
                        const InputDecoration(hintText: 'License Plate Number'),
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
                        await _addCityName();
                      } else {
                        await _updateItemLicpNum(id);
                      }
// Clear the text fields
                      _cityNameController.text = '';
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

  Future _addLicpNum() async {
    await SQLHelper.createLicensePlate(Licenseplate(
        licpNum: int.parse(_licpNumController.text), provinceId: widget.proId));
    _refreshItemsLicp();
  }

  Future<void> _deleteLicp(int id) async{
    await SQLHelper.deleteItemLicensePlate(id);
    _refreshItemsLicp();
  }

  //Scinecspots
  void _showFormAddSS() {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
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
                    controller: _ssNameController,
                    decoration: const InputDecoration(hintText: 'Scinecspots Name'),
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

                      await _addSSName();
// Clear the text fields
                      _ssNameController.text = '';
// Close the bottom sheet
// if you're not sure your widget is mounted.
// https://www.educative.io/answers/what-is-buildcontext-in-flutter)
                      if (!mounted) return;
                      Navigator.of(context).pop();
                    },
                    child: const Text('Create New'),
                  )
                ],
              ),
            ));
  }
  void _showFormUpdateSS(int? id) {
    //Kiem tra List cityItems co gai tri hay khong
    if (id != null && _licpItems.isNotEmpty) {
      final existingItem =
          _ssItems.firstWhere((element) => element['ssId'] == id);
      _ssNameController.text = existingItem['ssName'];
    } else {
      _ssNameController.text = '';
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
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
                    controller: _ssNameController,
                    decoration:
                        const InputDecoration(hintText: 'Scincespot Name'),
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
                      if (id != null) {
                        await _updateItemSSName(id);
                      }
// Clear the text fields
                      _ssNameController.text = '';
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

  Future _addSSName() async {
    await SQLHelper.createSS(ScinecSpot(
        ssName: _ssNameController.text, provinceId: widget.proId));
    _refreshItemsSS();
  }
  
  Future<void> _updateItemSSName(int id) async {
    await SQLHelper.updateItemScinecSpot(ScinecSpot(
        ssId: id,
        ssName: _ssNameController.text,
        provinceId: widget.proId));
    _refreshItemsSS();
  }

  Future<void> _deleteSS(int id) async {
    await SQLHelper.deleteItemScinecSpot(id);
    _refreshItemsSS();
  }

  //Universities
  void _showFormAddUn() {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
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
                    controller: _unNameController,
                    decoration: const InputDecoration(hintText: 'University Name'),
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

                      await _addUn();
// Clear the text fields
                      _unNameController.text = '';
// Close the bottom sheet
// if you're not sure your widget is mounted.
// https://www.educative.io/answers/what-is-buildcontext-in-flutter)
                      if (!mounted) return;
                      Navigator.of(context).pop();
                    },
                    child: const Text('Create New'),
                  )
                ],
              ),
            ));
  }

  void _showFormUpdateUn(int? id) {
    //Kiem tra List cityItems co gai tri hay khong
    if (id != null && _unItems.isNotEmpty) {
      final existingItem =
          _unItems.firstWhere((element) => element['unId'] == id);
      _unNameController.text = existingItem['unName'];
    } else {
      _unNameController.text = '';
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
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
                    controller: _unNameController,
                    decoration:
                        const InputDecoration(hintText: 'University Name'),
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
                      if (id != null) {
                        await _updateItemUnName(id);
                      }
// Clear the text fields
                      _unNameController.text = '';
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

  Future _addUn() async {
    await SQLHelper.createUniversity(University(
        unName: _unNameController.text, provinceId: widget.proId));
    _refreshItemsUN();
  }

  Future<void> _updateItemUnName(int id) async {
    await SQLHelper.updateItemUniversity(University(
        unId: id,
        unName: _unNameController.text,
        provinceId: widget.proId));
    _refreshItemsUN();
  }

  Future<void> _deleteUN(int id) async {
    await SQLHelper.deleteItemUniversity(id);
    _refreshItemsUN();
  }

  //Show detail and navigate
  void _showDetail(int cityId, String cityName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CityDetaiScreen(cityId: cityId, cityName: cityName),
        settings: RouteSettings(arguments: cityId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.pop(context);
        },),
          title: Text('${widget.provinceName}'),
        ),
        body: Column(
          children: [
            //City
            Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    const Text(
                      'Cities',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () => _showFormAddCity(),
                        icon: const Icon(Icons.add))
                  ],
                )),
            Expanded(
                child: ListView.builder(
                    itemCount: _cityItems.length,
                    itemBuilder: (context, index) => Card(
                          margin: const EdgeInsets.all(15),
                          child: ListTile(
                            title: Text(_cityItems[index]['cityName']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () => _showFormUpdateCity(
                                        _cityItems[index]['cityId']),
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () =>
                                      _deleteCity(_cityItems[index]['cityId']),
                                )
                              ],
                            ),
                          ),
                        ))),
            //const Divider(),
            Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    const Text(
                      'License Plate',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () => _showFormAddLicp(),
                        icon: const Icon(Icons.add))
                  ],
                )),
            Expanded(
                child: ListView.builder(
                    itemCount: _licpItems.length,
                    itemBuilder: (context, index) => Card(
                          margin: const EdgeInsets.all(15),
                          child: ListTile(
                            title: Text(_licpItems[index]['licpNum']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () => _showFormUpdateLicp(
                                        _licpItems[index]['licpId']),
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () =>
                                      _deleteLicp(_licpItems[index]['licpId']),
                                )
                              ],
                            ),
                          ),
                        ))),
            //const Divider(),
            //Scinecspots
            Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    const Text(
                      'Scinec Spots',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () => _showFormAddSS(),
                        icon: const Icon(Icons.add))
                  ],
                )),
            Expanded(
                child: ListView.builder(
                    itemCount: _ssItems.length,
                    itemBuilder: (context, index) => Card(
                          margin: const EdgeInsets.all(15),
                          child: ListTile(
                            title: Text(_ssItems[index]['ssName']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () => _showFormUpdateSS(
                                        _ssItems[index]['ssId']),
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () =>
                                      _deleteSS(_ssItems[index]['ssId']),
                                )
                              ],
                            ),
                          ),
                        ))),
                        //Universities
                        Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    const Text(
                      'University',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () => _showFormAddUn(),
                        icon: const Icon(Icons.add))
                  ],
                )),
            Expanded(
                child: ListView.builder(
                    itemCount: _unItems.length,
                    itemBuilder: (context, index) => Card(
                          margin: const EdgeInsets.all(15),
                          child: ListTile(
                            title: Text(_unItems[index]['unName']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () => _showFormUpdateUn(
                                        _unItems[index]['unId']),
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () =>
                                      _deleteUN(_unItems[index]['unId']),
                                )
                              ],
                            ),
                          ),
                        )))
          ],
        ));
        //floatingActionButton: FloatingActionButton(
        //  onPressed: _toggleAdditionalButtons,
        //  child: const Icon(Icons.swap_horiz),
        //));
  }
  
  
}
