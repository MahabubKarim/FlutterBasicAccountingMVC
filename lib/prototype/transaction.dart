import 'dart:core';

class Transaction {
  int id;
  int accountId;
  DateTime date;
  double debit;
  double credit;
  double balance;

  Transaction();

  Transaction.withId(int accountId) {
    this.accountId = accountId;
  }

}