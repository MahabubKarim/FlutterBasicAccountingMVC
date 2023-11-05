import 'package:accounting/account//account.dart';
import 'package:accounting/account/account_type.dart';
import 'package:accounting/account/transaction.dart' as tr;
import 'package:accounting/persistence/contract.dart';
import 'package:accounting/service/model.dart';
import 'package:sqflite/sqflite.dart';

class AccountStructure {

  void createTable(Database db) async {
    await db.execute("CREATE TABLE " + Account.getRuntimeType() + " ("
        + Model.ID_ + " INTEGER PRIMARY KEY AUTOINCREMENT,"
        + Model.ID + " INTEGER NOT NULL,"
        + AccountColumn.CODE + " TEXT,"
        + AccountColumn.TYPE_ID + " INTEGER,"
        + AccountColumn.NAME + " TEXT,"
        + "UNIQUE (" + Model.ID + ") ON CONFLICT REPLACE)");

    await db.execute("CREATE TABLE " + AccountType.getRuntimeType() + " ("
        + Model.ID_ + " INTEGER PRIMARY KEY AUTOINCREMENT,"
        + Model.ID + " INTEGER NOT NULL,"
        + AccountTypeColumn.NAME + " TEXT,"
        + "UNIQUE (" + Model.ID + ") ON CONFLICT REPLACE)");

    // TODO
    await db.execute("CREATE TABLE " + tr.Transaction.getRuntimeType() + " ("
        + Model.ID_ + " INTEGER PRIMARY KEY AUTOINCREMENT,"
        + Model.ID + " INTEGER NOT NULL,"
        + TransactionColumn.ACCOUNT_ID + " INTEGER NOT NULL,"
        + TransactionColumn.DATE + " TEXT,"
        + TransactionColumn.DEBIT + " DOUBLE,"
        + TransactionColumn.CREDIT + " DOUBLE,"
        + TransactionColumn.BALANCE + " DOUBLE,"
        + "UNIQUE (" + Model.ID + ") ON CONFLICT REPLACE)");

  }

}
