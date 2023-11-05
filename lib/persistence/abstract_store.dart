import 'dart:async';

import 'package:accounting/persistence/persistence.dart';
import 'package:sqflite/sqflite.dart';

import '../service/model.dart';

abstract class AbstractStore<T extends Model> {

  Persistence persistence;

  AbstractStore() {
    if (persistence == null) {
      persistence = Persistence(); // This is executed only once, singleton object
    }
  }

  // ignore: missing_return
  Model getModel() {}

  //TODO
  // ignore: missing_return
  Model toEntity(Map<String, dynamic> map) {}

  String getModelName() {
    return getModel().runtimeType.toString();
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'account List' [ List<account> ]
  Future<T> readById(int id) async {
    Database db = await this.persistence.database;
    var result = await db.query(getModelName(), where: Model.ID + ' = ?', whereArgs: [id]);
    List<T> accounts = List<T>();
    for (int i = 0; i < result.length; i++) {
      accounts.add(toEntity(result[i]));
    }
    return accounts[0];
  }

  Future<List<T>> readAll() async {
    Database db = await this.persistence.database;
    var result = await db.query(getModelName());
    List<T> accounts = List<T>();
    for (int i = 0; i < result.length; i++) {
      accounts.add(toEntity(result[i]));
    }
    return accounts;
  }

  // Insert Operation: Insert a account object to database
  Future<int> insert(T account) async {
    var db = await this.persistence.database;
    String entity = getModelName();
    var result = await db.insert(entity, account.toEntity());
    return result;
  }

  // Update Operation: Update a account object and save it to database
  Future<int> merge(T account) async {
    Database db = await this.persistence.database;
    int id = account.getId();
    var result = await db.update(getModelName(), account.toEntity(), where: Model.ID + ' = ?', whereArgs: [id]);
    return result;
  }

  // Delete Operation: Delete a account object from database
  Future<int> purge(T account) async {
    var db = await this.persistence.database;
    int id = account.getId();
    int result = await db.rawDelete('DELETE FROM ' + getModelName() + ' WHERE ' + Model.ID + ' = $id');
    return result;
  }

}
