import 'package:accounting/account/account_type.dart';
import 'package:accounting/account/account_type_list_view.dart';
import 'package:accounting/service/account_type_service.dart';
import 'package:flutter/material.dart';

import 'account_type_create_view.dart';
import 'account_type_detail_view.dart';
import 'account_type_edit_view.dart';

// ignore: must_be_immutable
class AccountTypeController extends StatefulWidget {
  State _state;
  AccountTypeService _typeService = AccountTypeService();
  AccountType accountType;
  Future<List<AccountType>> list;
  int counter = 0;
  int count = 0;

  @override
  State createState() {
    return _state;
  }

  init() {
    AccountTypeService.sync();
    list = listAccountTypes();
  }

  AccountTypeController() {
    _state = AccountTypeListView();
     init();
  }

  AccountTypeController.create() {
    _state = AccountTypeCreateView();
    accountType = new AccountType();
    init();
  }

  AccountTypeController.edit(AccountType accountType) {
    _state = AccountTypeEditView();
    this.accountType = accountType;
    init();
  }

  AccountTypeController.detail(AccountType accountType) {
    _state = AccountTypeDetailView();
    this.accountType = accountType;
  }

  Future<List<AccountType>> listAccountTypes() {
    return _typeService.listAccountTypes();
  }

  void createAccountType(AccountType account) {
    _typeService.createAccountType(account);
  }

  void updateAccountType(AccountType account) async {
    _typeService.updateAccountType(account);
  }

  void deleteAccountType(AccountType account) async {
    _typeService.deleteAccountType(account);
  }

}