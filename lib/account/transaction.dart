import 'package:accounting/persistence/contract.dart';
import 'package:accounting/prototype/transaction.dart' as pb;
import 'package:accounting/service/abstract_model.dart';
import 'package:accounting/service/model.dart';

class Transaction extends AbstractModel {
  static String getRuntimeType() {
    return "Tranzaction";
  }

  int accountId;
  DateTime date;
  double debit;
  double credit;
  double balance;

  Transaction();

  // Convert a Transaction object into a Map object
  Map<String, dynamic> toEntity() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map[Model.ID] = id;
    }
    map[TransactionColumn.ACCOUNT_ID] = accountId;
    map[TransactionColumn.DATE] = date;
    map[TransactionColumn.DEBIT] = debit;
    map[TransactionColumn.CREDIT] = credit;
    map[TransactionColumn.BALANCE] = balance;
    return map;
  }

  // Extract a Transaction object from a Map object
  Transaction.toEntity(Map<String, dynamic> map) {
    this.accountId = map[TransactionColumn.ACCOUNT_ID];
    this.date = map[TransactionColumn.DATE];
    this.debit = map[TransactionColumn.DEBIT];
    this.credit = map[TransactionColumn.CREDIT];
    this.balance = map[TransactionColumn.BALANCE];
  }

  Transaction.of(pb.Transaction transaction){
    this.accountId = transaction.accountId;
    this.date = transaction.date;
    this.debit = transaction.debit;
    this.credit = transaction.credit;
    this.balance = transaction.balance;
  }

  pb.Transaction toMessage(){
    pb.Transaction transaction = pb.Transaction();
    transaction.accountId = this.accountId;
    transaction.date = this.date;
    transaction.debit = this.debit;
    transaction.credit = this.credit;
    transaction.balance = this.balance;
    return transaction;
  }
}
