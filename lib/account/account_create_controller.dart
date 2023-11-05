import 'package:accounting/account/account_controller.dart';
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
class AccountCreateController extends AccountController {
  WidgetMarker widgetMarker;
  Function(WidgetMarker) callback;

  @override
  State createState() {
    return AccountCreateView();
  }

  AccountCreateController(this.widgetMarker, this.callback) {
    AccountTypeService.sync();
    types = typeService.listAccountTypes();
    list = new List<Account>();
    account = new Account();
  }

}
