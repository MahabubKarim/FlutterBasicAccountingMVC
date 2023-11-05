import 'package:accounting/account/account_detail_view.dart';
import 'package:accounting/account/account_list_view.dart';
import 'package:accounting/account/account_type.dart';
import 'package:accounting/account/account_view.dart';
import 'package:accounting/service/account_service.dart';
import 'package:accounting/service/account_type_service.dart';
import 'package:flutter/material.dart';

import 'account.dart';
import 'account_controller.dart';
import 'account_create_view.dart';
import 'account_edit_view.dart';

// ignore: must_be_immutable
class AccountListController extends AccountController {
  WidgetMarker widgetMarker;
  Function(Account, WidgetMarker) callbackWithAccount;

  @override
  State createState() {
    return AccountListView();
  }

  AccountListController(this.widgetMarker, this.callbackWithAccount) {
    AccountService.sync();
    list = new List<Account>();
    account = new Account();
  }
}
