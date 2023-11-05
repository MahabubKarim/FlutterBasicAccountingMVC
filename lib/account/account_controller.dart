import 'package:accounting/account/account_detail_view.dart';
import 'package:accounting/account/account_list_view.dart';
import 'package:accounting/account/account_type.dart';
import 'package:accounting/service/account_service.dart';
import 'package:accounting/service/account_type_service.dart';
import 'package:flutter/material.dart';

import 'account.dart';
import 'account_create_view.dart';
import 'account_edit_view.dart';
import 'account_view.dart';

// ignore: must_be_immutable
class AccountController extends StatefulWidget {
  AccountService _service = AccountService();
  @protected AccountTypeService typeService = AccountTypeService();
  List<Account> list;
  Future<List<AccountType>> types;
  Account account;
  int count = 0;

  @override
  State createState() {
    return AccountView();
  }

  Future<List<Account>> listAccounts() async {
    return await _service.listAccounts();
  }

  void createAccount(Account account) {
    _service.createAccount(account);
  }

  void updateAccount(Account account) async {
    _service.updateAccount(account);
  }

  void deleteAccount(Account account) async {
    _service.deleteAccount(account);
  }

}
