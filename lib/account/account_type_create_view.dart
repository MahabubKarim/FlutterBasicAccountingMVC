import 'package:accounting/account/account_type.dart';
import 'package:flutter/material.dart';

import 'account_type_controller.dart';
import 'widgets/navigation_drawer.dart';

class AccountTypeCreateView extends State<AccountTypeController> {
  AccountType selectedAccountType;
  String typeName = "";
  int listSize = 0;
  List<DropdownMenuItem<AccountType>> dropdownItems = List();
  List<AccountType> accountTypes = List();
  Map<int, AccountType> dropDownItemsMap = new Map();

  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    buildDropDownItems();
    setListSize();
  }

  void setListSize() {
    widget.list.then((list) => {
      if (list != null) {
        setState(() {
          listSize = list.length;
        })
      }
    });
  }

  void buildDropDownItems() {
    widget.list.then((list) => {
      if (list != null) {
        setState(() {
          selectedAccountType = list.first;
          for (AccountType type in list) {
            dropdownItems.add(new DropdownMenuItem(value: type, child: Text(type.name)));
            accountTypes.add(type);
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

  void _save(BuildContext context) async {
    widget.accountType.id =  listSize + 1;
    widget.accountType.name = typeName;
    widget.createAccountType(widget.accountType);
    _showSnackBar(context, 'Account Type Created Successfully');
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => AccountTypeController()));
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return WillPopScope (
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => AccountTypeController()));
        return true;
      },
      child : Scaffold(
        appBar: AppBar(title: Text("New Account Type")),
        body: Builder(
          builder: (context) => Container(
            height: 280,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card (
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

                      // Second Element
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextField(
                          controller: nameController,
                          style: textStyle,
                          onChanged: (value) {
                            debugPrint('Something changed in Title Text Field');
                            typeName = value;
                          },
                          decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: textStyle,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),

                      // Fifth Element
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
                                    _save(context);
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
        ),),);
  }
}
