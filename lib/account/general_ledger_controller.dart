import 'package:accounting/account/transaction.dart';
import 'package:accounting/service/transaction_service.dart';
import 'package:flutter/material.dart';

import 'general_ledger_view.dart';

// ignore: must_be_immutable
class GeneralLedgerController extends StatefulWidget {
  TransactionService _service = TransactionService();
  List<Transaction> list;
  Transaction account;
  int count = 0;

  @override
  State createState() {
    return GeneralLedgerView();
  }

  GeneralLedgerController() {
    TransactionService.sync();
    list = List<Transaction>();
    account = new Transaction();
  }

  List<Transaction> listTransactions() {
    return _service.listTransactions();
  }

  void createTransaction(Transaction transaction) {
    _service.createTransaction(transaction);
  }

  void updateTransaction(Transaction transaction) async {
    _service.updateTransaction(transaction);
  }

  void deleteTransaction(Transaction transaction) async {
    _service.deleteTransaction(transaction);
  }
}
