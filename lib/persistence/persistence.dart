import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'store_schema.dart';

class Persistence {
  static Persistence _persistence;
  static Database _database;

  Persistence._createInstance(); // Named constructor to create instance of Store

  Persistence() {
    if (_persistence == null) {
      _persistence = Persistence._createInstance(); // This is executed only once, singleton object
    }
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'accounts.db';
    var db = await openDatabase(path, version: 1, onCreate: _createDb);
    return db;
  }

  void _createDb(Database db, int newVersion) {
    StoreSchema.create(db);
  }
}
