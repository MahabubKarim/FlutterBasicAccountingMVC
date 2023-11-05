import 'package:accounting/account/account.dart';
import 'package:accounting/account/account_type.dart';
import 'package:accounting/account/account_view.dart';
import 'package:flutter/material.dart';

import 'account_detail_controller.dart';

class AccountDetailView extends State<AccountDetailController> {
  AccountType selectedAccountType;
  List<DropdownMenuItem<AccountType>> dropdownItems = List();
  Map<int, Account> dropDownItemsMap = new Map();
  int counter = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //Navigator.of(context).popUntil((route) => route.isFirst);
        widget.callback(WidgetMarker.list);
        return false;
      },
      child: Container(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            color: Colors.white,
            elevation: 2.0,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: Text("Account Name", textScaleFactor: 1.3)),
                    Expanded(child: Text(widget.account.name, textScaleFactor: 1.3)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(child: Text("Account Code", textScaleFactor: 1.3)),
                    Expanded(child: Text(widget.account.code, textScaleFactor: 1.3)),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
