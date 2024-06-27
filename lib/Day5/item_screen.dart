import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Day5/item.dart';
import 'package:myapp/Day5/sql_helper.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  // All items
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = true;

// This function is used to fetch all data from the database
  Future<void> _refreshItems() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _items = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshItems(); // Loading the diary when the app starts
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

// This function will be triggered when the floating button is pressed
// It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingItem = _items.firstWhere((element) => element['id'] == id);
      _titleController.text = existingItem['title'];
      _descriptionController.text = existingItem['description'];
    } else {
      _titleController.text = '';
      _descriptionController.text = '';
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
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: 'Title'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    controller: _descriptionController,
                    decoration: const InputDecoration(hintText: 'Description'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
// Save new item
                      if (id == null) {
                        await _addItem();
                      } else {
                        await _updateItem(id);
                      }
// Clear the text fields
                      _titleController.text = '';
                      _descriptionController.text = '';
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

  // Insert a new item to the database
  Future<void> _addItem() async {
    await SQLHelper.createItem(Item(
        title: _titleController.text,
        description: _descriptionController.text));
    _refreshItems();
  }

// Update an existing item
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(Item(
        id: id,
        title: _titleController.text,
        description: _descriptionController.text));
    _refreshItems();
  }

// Delete an item
  Future<void> _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
// if you're not sure your widget is mounted. if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a item!'),
    ));
    _refreshItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persist data with SQLite'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) => Card(
                color: Colors.orange[200],
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text(_items[index]['title']),
                  subtitle: Text(_items[index]['description']),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showForm(_items[index]['id']),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteItem(_items[index]['id']),
                      )
                    ]),
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: ()=>_showForm(null)
            ),
    );
  }
}
