import 'package:accounting/account/account.dart';
import 'package:accounting/account/account_controller.dart';
import 'package:accounting/account/account_type.dart';
import 'package:accounting/account/account_view.dart';
import 'package:flutter/material.dart';

import 'account_edit_controller.dart';

class AccountEditView extends State<AccountEditController> {
  AccountType selectedAccountType;
  List<DropdownMenuItem<AccountType>> dropdownItems = List();
  Map<int, Account> dropDownItemsMap = new Map();

  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  void buildDropDownItems() {
    widget.types.then((list) => {
      if (list != null) {
          setState(() {
            selectedAccountType = list[widget.account.typeId-1];
            for (AccountType type in list) {
              dropdownItems.add(new DropdownMenuItem(value: type, child: Text(type.name)));
            }
          })
        }
    });
  }

  void onChangedDropdownItem(AccountType accountType) {
    setState(() {
      selectedAccountType = accountType;
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    // Scaffold.of(context).showSnackBar(snackBar);
  }

  void _deleteAccount(BuildContext context, Account account) async {
    widget.deleteAccount(account);
    _showSnackBar(context, 'Account Deleted Successfully');
    widget.callback(WidgetMarker.list);
  }

  void _editAccount(BuildContext context, Account account) async {
    widget.account.typeId = selectedAccountType.id;
    widget.updateAccount(account);
    _showSnackBar(context, 'Account Updated Successfully');
    widget.callback(WidgetMarker.list);
  }

  Future<void> deleteAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you really want to delete?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('YES'),
              onPressed: () {
                _deleteAccount(context, widget.account);
                widget.callback(WidgetMarker.list);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('NO'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    buildDropDownItems();
    nameController.text = widget.account.name;
    codeController.text = widget.account.code;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return WillPopScope(
      onWillPop: () async {
        widget.callback(WidgetMarker.list);
        return false;
      },
      child: Builder(
        builder: (context) => Container(
          height: 380,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              color: Colors.white,
              elevation: 2.0,
              child: Padding(
                padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                child: ListView(
                  children: <Widget>[
                    // Account Type
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey, style: BorderStyle.solid),
                        ),
                        child: new Container(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton(
                                      isExpanded: true,
                                      items: dropdownItems,
                                      value: selectedAccountType,
                                      style: textStyle,
                                      onChanged: onChangedDropdownItem,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextField(
                        controller: nameController,
                        style: textStyle,
                        onChanged: (value) {
                          debugPrint('Something changed in Title Text Field');
                          widget.account.name = value;
                        },
                        decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: textStyle,
                            border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextField(
                        controller: codeController,
                        style: textStyle,
                        onChanged: (value) {
                          debugPrint('Something changed in Description Text Field');
                          widget.account.code = value;
                        },
                        decoration: InputDecoration(
                            labelText: 'Code',
                            labelStyle: textStyle,
                            border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: RaisedButton(
                                color: Theme.of(context).primaryColorDark,
                                textColor: Colors.white,
                                child: Text(
                                  'Update',
                                  textScaleFactor: 1.5,
                                ),
                                onPressed: () {
                                  setState(() {
                                    debugPrint("Update button clicked");
                                    _editAccount(context, widget.account);
                                  });
                                },
                              ),
                            ),
                          ),

                          /*Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: RaisedButton(
                              color: Theme.of(context).primaryColorDark,
                              textColor: Colors.white,
                              child: Text(
                                'Delete',
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  debugPrint("Delete button clicked");
                                  _deleteAccount(context, widget.account);
                                });
                              },
                            ),
                          ),
                        ),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
