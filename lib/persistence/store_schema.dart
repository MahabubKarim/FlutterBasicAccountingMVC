import 'package:sqflite/sqflite.dart';

import 'account_structure.dart';

class BaseColumns {
  static const String ID = "_id";
  static const String COUNT = "_count";
}

class StoreSchema {

  static void create(Database db){
    new AccountStructure().createTable(db);
  }

}