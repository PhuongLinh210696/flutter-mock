import 'package:flutter/rendering.dart';
import 'package:myapp/Day5/item.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;
  static const _itemsTable = 'items';

  static const _columnId = 'id';
  static const _columnTitle = 'title';
  static const _columnDescription = 'description';
  static const _columnCreatedAt = 'createdAt';

  //CREATE Database
  static Future<void> createItemTable(Database database) async {
    try {
      await database.execute('''
CREATE TABLE $_itemsTable (
$_columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $_columnTitle TEXT,
$_columnDescription TEXT,
$_columnCreatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
)''');
    } catch (err) {
      debugPrint("createItemTable(): $err");
    }
  }

  static Future<Database> getDb() async {
    return openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: (Database database, int version) async {
        await createItemTable(database);
      },
    );
  }

//Create new item
  static Future<int> createItem(Item item) async {
    int id = 0;

    try {
      final db = await SQLHelper.getDb();

      // Sometimes you want to insert an empty row, in that case ContentValues
      // have no content value, and you should use nullColumnHack.
      // For example, you want to insert an empty row into a table student(id, name),
      // which id is auto generated and name is null.
      id = await db.insert(_itemsTable, item.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (err) {
      debugPrint("createItem(): $err");
    }

    return id;
  }

  //Read all item
  static Future<List<Map<String, dynamic>>> getItems() async {
    late Future<List<Map<String, dynamic>>> items;

    try {
      final db = await SQLHelper.getDb();
      items = db.query(_itemsTable, orderBy: _columnId);
    } catch (err) {
      debugPrint("getItems: $err");
    }
    return items;
  }

  // Read a single item by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    late Future<List<Map<String, dynamic>>> item;

    try {
      final db = await SQLHelper.getDb();
      item = db.query(_itemsTable,
          where: "$_columnId = ?", whereArgs: [id], limit: 1);
    } catch (err) {
      debugPrint("getItems: $err");
    }
    return item;
  }

  // Update an item by id
  static Future<int> updateItem(Item item) async {
    int result = 0;
    try {
      final db = await SQLHelper.getDb();
      result = await db.update(_itemsTable, item.toMap(),
          where: "$_columnId = ?", whereArgs: [item.id]);
    } catch (err) {
      debugPrint("updateItem(): $err");
    }
    return result;
  }

  // Delete a single item by id
  static Future<void> deleteItem(int id) async {
    try {
      final db = await SQLHelper.getDb();
      await db.delete(_itemsTable, where: "$_columnId = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
