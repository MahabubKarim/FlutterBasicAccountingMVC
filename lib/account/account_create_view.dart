import 'package:accounting/account/account.dart';
import 'package:accounting/account/account_controller.dart';
import 'package:accounting/account/account_type.dart';
import 'package:accounting/account/account_view.dart';
import 'package:flutter/material.dart';

import 'account_create_controller.dart';

class AccountCreateView extends State<AccountCreateController> {
  AccountType selectedAccountType;
  List<DropdownMenuItem<AccountType>> dropdownItems = List();
  Map<int, Account> dropDownItemsMap = new Map();

  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  int listSize = 0;

  void setListSize() {
    Future<List<Account>> accounts = widget.listAccounts();
    accounts.then((accountList) {
      if (accountList != null) {
        listSize = accountList.length;
      }
    });
  }

  void buildDropDownItems() {
    widget.types.then((list) => {
    if (list != null) {
        setState(() {
          selectedAccountType = list.first;
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
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _save() async {
    widget.account.id = listSize + 1;
    widget.account.typeId = selectedAccountType.id;
    widget.createAccount(widget.account);
    widget.callback(WidgetMarker.list);
  }

  @override
  void initState() {
    super.initState();
    buildDropDownItems();
    setListSize();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return WillPopScope(
      onWillPop: () async {
        widget.callback(WidgetMarker.list);
        return false;
      },
      child: Container(
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
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
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
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Colors.white,
                            child: Text(
                              'Create',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                debugPrint("Save button clicked");
                                _save();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
