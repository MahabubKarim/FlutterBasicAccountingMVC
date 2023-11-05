import 'package:accounting/account/account_controller.dart';
import 'package:accounting/account/account_type.dart';
import 'package:accounting/service/account_type_service.dart';
import 'package:flutter/material.dart';

import 'account.dart';
import 'account_edit_view.dart';
import 'account_view.dart';

// ignore: must_be_immutable
class AccountEditController extends AccountController {
  WidgetMarker widgetMarker;
  Function(WidgetMarker) callback;

  @override
  State createState() {
    return AccountEditView();
  }

  AccountEditController(Account account, this.widgetMarker, this.callback) {
    AccountTypeService.sync();
    types = typeService.listAccountTypes();
    this.account = account;
  }
}
