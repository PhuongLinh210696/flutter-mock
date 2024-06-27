import 'package:flutter/material.dart';
import 'package:myapp/Mock/SQLHelper/city.dart';
import 'package:myapp/Mock/SQLHelper/licenseplate.dart';
import 'package:myapp/Mock/province.dart';
import 'package:myapp/Mock/SQLHelper/scinecspot.dart';
import 'package:myapp/Mock/SQLHelper/university.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static const _databaseName = "ProvincesDatabase.db";
  static const _databaseVersion = 2;

  static const _provincesTable = 'provinces';
  static const _citiesTable = 'cities';
  static const _scinecspotsTable = 'scinecspots';
  static const _universitiesTable = 'universities';
  static const _licenseplatesTable = 'licenseplates';

  // CREATE DATABASE
  static Future<void> createItemTable(Database database) async {
    try {
      // Table Provinces
      await database.execute('''
        CREATE TABLE $_provincesTable (
          provinceId INTEGER PRIMARY KEY AUTOINCREMENT,
          provinceName TEXT
        )
      ''');

      // Table Cities
      await database.execute('''
        CREATE TABLE $_citiesTable (
          cityId INTEGER PRIMARY KEY AUTOINCREMENT,
          cityName TEXT,
          provinceId INTEGER,
          FOREIGN KEY (provinceId) REFERENCES $_provincesTable (provinceId) ON DELETE CASCADE ON UPDATE CASCADE
        )
      ''');

      // Table Scinec Spots
      await database.execute('''
        CREATE TABLE $_scinecspotsTable (
          ssId INTEGER PRIMARY KEY AUTOINCREMENT,
          ssName TEXT,
          provinceId INTEGER,
          FOREIGN KEY (provinceId) REFERENCES $_provincesTable (provinceId) ON DELETE CASCADE ON UPDATE CASCADE
        )
      ''');

      // Table Universities
      await database.execute('''
        CREATE TABLE $_universitiesTable (
          unId INTEGER PRIMARY KEY AUTOINCREMENT,
          unName TEXT,
          provinceId INTEGER,
          FOREIGN KEY (provinceId) REFERENCES $_provincesTable (provinceId) ON DELETE CASCADE ON UPDATE CASCADE
        )
      ''');

      // Table License Plates
      await database.execute('''
        CREATE TABLE $_licenseplatesTable (
          licpId INTEGER PRIMARY KEY AUTOINCREMENT,
          licpNum TEXT,
          provinceId INTEGER,
          FOREIGN KEY (provinceId) REFERENCES $_provincesTable (provinceId) ON DELETE CASCADE ON UPDATE CASCADE
        )
      ''');
    } catch (err) {
      debugPrint("$err");
    }
  }

  // UPGRADE DATABASE
  static Future<void> upgradeItemTable(Database database, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add provinceId column to scinecspots
      await database.execute('''
        ALTER TABLE $_scinecspotsTable ADD COLUMN provinceId INTEGER;
      ''');

      // Add provinceId column to universities
      await database.execute('''
        ALTER TABLE $_universitiesTable ADD COLUMN provinceId INTEGER;
      ''');
      

      await database.execute('''
        ALTER TABLE $_universitiesTable ADD COLUMN unId INTEGER PRIMARY KEY AUTOINCREMENT
''');
    }
  }
  
  // OPEN DATABASE
  static Future<Database> getDb() async {
    return openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: (Database database, int version) async {
        await createItemTable(database);
      },
      onUpgrade: (Database database, int oldVersion, int newVersion) async {
        await upgradeItemTable(database, oldVersion, newVersion);
      },
    );
  }

  //Create new province
  static Future<int> createProvince(Province item) async {
    int id = 0;

    try {
      final db = await SQLHelper.getDb();
      id = await db.insert(_provincesTable, item.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (err) {
      debugPrint("createItem(): $err");
    }

    return id;
  }

  //Read all item Province
  static Future<List<Map<String, dynamic>>> getItemsProvince() async {
    late Future<List<Map<String, dynamic>>> items;

    try {
      final db = await SQLHelper.getDb();
      items = db.query(_provincesTable, orderBy: 'provinceId');
    } catch (err) {
      debugPrint("getItems: $err");
    }
    return items;
  }

  // Read a single province by id
  static Future<List<Map<String, dynamic>>> getItemProvince(int provinceId) async {
    late Future<List<Map<String, dynamic>>> item;

    try {
      final db = await SQLHelper.getDb();
      item = db.query(_provincesTable,
          where: "provinceId = ?", whereArgs: [provinceId], limit: 1);
    } catch (err) {
      debugPrint("getItems: $err");
    }
    return item;
  }

  // Update an province by id
  static Future<int> updateItemProvince(Province itemProvince) async {
    int result = 0;
    try {
      final db = await SQLHelper.getDb();
      result = await db.update(_provincesTable, itemProvince.toMap(),
          where: "provinceId = ?", whereArgs: [itemProvince.provinceId]);
    } catch (err) {
      debugPrint("updateItem(): $err");
    }
    return result;
  }

  // Delete a single province by id
  static Future<void> deleteItemProvince(int provinceId) async {
    try {
      final db = await SQLHelper.getDb();
      await db.delete(_provincesTable, where: "provinceId = ?", whereArgs: [provinceId]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  //Create new city
  static Future<int> createCity(City item) async {
    int id = 0;

    try {
      final db = await SQLHelper.getDb();
      id = await db.insert(_citiesTable, item.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (err) {
      debugPrint("createItem(): $err");
    }

    return id;
  }

  //Read all item cties
  static Future<List<Map<String, dynamic>>> getItemsCity() async {
    late Future<List<Map<String, dynamic>>> items;

    try {
      final db = await SQLHelper.getDb();
      items = db.query(_citiesTable, orderBy: 'cityId');
    } catch (err) {
      debugPrint("getItems: $err");
    }
    return items;
  }

  // Read a single city by id
  static Future<List<Map<String, dynamic>>> getItemCity(int cityId) async {
    late Future<List<Map<String, dynamic>>> item;

    try {
      final db = await SQLHelper.getDb();
      item = db.query(_citiesTable,
          where: "cityId = ?", whereArgs: [cityId], limit: 1);
    } catch (err) {
      debugPrint("getItems: $err");
    }
    return item;
  }

  //Read a single city by provinceId
  static Future<List<Map<String,dynamic>>> getItemCitybyProId(int? proId) async{
    late Future<List<Map<String,dynamic>>> item;

    try{
      final db = await SQLHelper.getDb();
      item = db.query(_citiesTable,where: "provinceId = ?",whereArgs: [proId]);
    }catch(err){
      debugPrint("getItem: $err");
    }

    return item;
  }
  
  // Update a city by id
  static Future<int> updateItemCity(City itemCity) async {
    int result = 0;
    try {
      final db = await SQLHelper.getDb();
      result = await db.update(_citiesTable, itemCity.toMap(),
          where: "cityId = ?", whereArgs: [itemCity.cityId]);
    } catch (err) {
      debugPrint("updateItem(): $err");
    }
    return result;
  }

  // Delete a single city by id
  static Future<void> deleteItemCity(int cityId) async {
    try {
      final db = await SQLHelper.getDb();
      await db.delete(_citiesTable, where: "cityId = ?", whereArgs: [cityId]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
  
  //Create new ScinecSpot
  static Future<int> createSS(ScinecSpot item) async {
    int id = 0;

    try {
      final db = await SQLHelper.getDb();
      id = await db.insert(_scinecspotsTable, item.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (err) {
      debugPrint("createItem(): $err");
    }

    return id;
  }

  //Read all item ScinecSpot
  static Future<List<Map<String, dynamic>>> getItemsScinecSpot() async {
    late Future<List<Map<String, dynamic>>> items;

    try {
      final db = await SQLHelper.getDb();
      items = db.query(_scinecspotsTable, orderBy: 'ssId');
    } catch (err) {
      debugPrint("getItems: $err");
    }
    return items;
  }

  // Read a single scinespot by id
  static Future<List<Map<String, dynamic>>> getItemSs(int ssId) async {
    late Future<List<Map<String, dynamic>>> item;

    try {
      final db = await SQLHelper.getDb();
      item = db.query(_scinecspotsTable,
          where: "ssId = ?", whereArgs: [ssId], limit: 1);
    } catch (err) {
      debugPrint("getItems: $err");
    }
    return item;
  }

  //Read a single scinespot by provinceId
  static Future<List<Map<String,dynamic>>> getItemSsByProId(int? proId) async{
    late Future<List<Map<String,dynamic>>> item;

    try{
      final db = await SQLHelper.getDb();
      item = db.query(_scinecspotsTable,where: "provinceId = ?",whereArgs: [proId]);
    }catch(err){
      debugPrint("getItem: $err");
    }

    return item;
  }

  // Update a scinespot by id
  static Future<int> updateItemScinecSpot(ScinecSpot item) async {
    int result = 0;
    try {
      final db = await SQLHelper.getDb();
      result = await db.update(_scinecspotsTable, item.toMap(),
          where: "ssId = ?", whereArgs: [item.ssId]);
    } catch (err) {
      debugPrint("updateItem(): $err");
    }
    return result;
  }

  // Delete a single scinespot by id
  static Future<void> deleteItemScinecSpot(int ssId) async {
    try {
      final db = await SQLHelper.getDb();
      await db.delete(_scinecspotsTable, where: "ssId = ?", whereArgs: [ssId]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  //Create new University
  static Future<int> createUniversity(University item) async {
    int id = 0;

    try {
      final db = await SQLHelper.getDb();
      id = await db.insert(_universitiesTable, item.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (err) {
      debugPrint("createItem(): $err");
    }

    return id;
  }

  //Read all item Universities
  static Future<List<Map<String, dynamic>>> getItemsUniversity() async {
    late Future<List<Map<String, dynamic>>> items;

    try {
      final db = await SQLHelper.getDb();
      items = db.query(_universitiesTable, orderBy: 'unId');
    } catch (err) {
      debugPrint("getItems: $err");
    }
    return items;
  }

  // Read a single university by id
  static Future<List<Map<String, dynamic>>> getItemUniversity(int unId) async {
    late Future<List<Map<String, dynamic>>> item;

    try {
      final db = await SQLHelper.getDb();
      item = db.query(_universitiesTable,
          where: "unId = ?", whereArgs: [unId], limit: 1);
    } catch (err) {
      debugPrint("getItems: $err");
    }
    return item;
  }

  //Read a single university by provinceId
  static Future<List<Map<String,dynamic>>> getItemUniByProId(int? proId) async{
    late Future<List<Map<String,dynamic>>> item;

    try{
      final db = await SQLHelper.getDb();
      item = db.query(_universitiesTable,where: "provinceId = ?",whereArgs: [proId]);
    }catch(err){
      debugPrint("getItem: $err");
    }

    return item;
  }

  // Update a university by id
  static Future<int> updateItemUniversity(University itemUniversity) async {
    int result = 0;
    try {
      final db = await SQLHelper.getDb();
      result = await db.update(_universitiesTable, itemUniversity.toMap(),
          where: "unId = ?", whereArgs: [itemUniversity.unId]);
    } catch (err) {
      debugPrint("updateItem(): $err");
    }
    return result;
  }

  // Delete a single university by id
  static Future<void> deleteItemUniversity(int unId) async {
    try {
      final db = await SQLHelper.getDb();
      await db.delete(_universitiesTable, where: "unId = ?", whereArgs: [unId]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  //Create new license plate
  static Future<int> createLicensePlate(Licenseplate item) async {
    int id = 0;

    try {
      final db = await SQLHelper.getDb();
      id = await db.insert(_licenseplatesTable, item.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (err) {
      debugPrint("createItem(): $err");
    }

    return id;
  }

  //Read all item License Plates
  static Future<List<Map<String, dynamic>>> getItemsLicensePlate() async {
    late Future<List<Map<String, dynamic>>> items;

    try {
      final db = await SQLHelper.getDb();
      items = db.query(_licenseplatesTable, orderBy: 'licpId');
    } catch (err) {
      debugPrint("getItems: $err");
    }
    return items;
  }

  // Read a single license plate by id
  static Future<List<Map<String, dynamic>>> getItemLicensePlateByProId(int? proId) async {
    late Future<List<Map<String, dynamic>>> item;

    try {
      final db = await SQLHelper.getDb();
      item = db.query(_licenseplatesTable,
          where: "provinceId = ?", whereArgs: [proId]);
    } catch (err) {
      debugPrint("getItems: $err");
    }
    return item;
  }

  // Update a license plate by id
  static Future<int> updateItemLicensePlate(Licenseplate itemLicensePlate) async {
    int result = 0;
    try {
      final db = await SQLHelper.getDb();
      result = await db.update(_licenseplatesTable, itemLicensePlate.toMap(),
          where: "licpId = ?", whereArgs: [itemLicensePlate.licpId]);
    } catch (err) {
      debugPrint("updateItem(): $err");
    }
    return result;
  }

  // Delete a single license plate by id
  static Future<void> deleteItemLicensePlate(int licpId) async {
    try {
      final db = await SQLHelper.getDb();
      await db.delete(_licenseplatesTable, where: "licpId = ?", whereArgs: [licpId]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
