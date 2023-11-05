import 'package:accounting/account/account.dart';
import 'package:accounting/account/account_controller.dart';
import 'package:accounting/account/account_detail_controller.dart';
import 'package:accounting/account/account_list_view.dart';
import 'package:accounting/account/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';

import 'account_create_controller.dart';
import 'account_edit_controller.dart';
import 'account_list_controller.dart';

enum WidgetMarker {list, detail, create, edit}

class AccountView extends State<AccountController> {

  //region Variables
  WidgetMarker _widgetMarker = WidgetMarker.list;
  String title = "Account List";
  bool isVisibleAdd = false;
  bool isVisibleEdit = false;
  bool isVisibleDelete = false;
  //endregion

  //region Methods
  void updateListView() {
    Future<List<Account>> accounts = widget.listAccounts();
    accounts.then((accountList) {
      if (accountList != null) {
        setState(() {
          widget.list = accountList;
          widget.count = accountList.length;
        });
      }
    });
  }

  callback(WidgetMarker widgetMarker) {
    setState(() {
      _widgetMarker = widgetMarker;
      buildChildView();
    });
  }

  callbackWithAccount(Account account, WidgetMarker widgetMarker) {
    setState(() {
      widget.account = account;
      _widgetMarker = widgetMarker;
      buildChildView();
    });
  }

  void hideShowAppBarActions(bool isAdd, bool isEdit, bool isDelete) {
    isVisibleAdd = isAdd;
    isVisibleEdit = isEdit;
    isVisibleDelete = isDelete;
  }

  Future<void> deleteAccountDialog() async {
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
                widget.deleteAccount(widget.account);
                Navigator.of(context).pop();
                callback(WidgetMarker.list);
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

  Widget buildChildView() {
    if (_widgetMarker == WidgetMarker.edit) {
      title = "Edit Account";
      hideShowAppBarActions(false, false, true);
      return AccountEditController(widget.account, _widgetMarker, callback);
    } else if (_widgetMarker == WidgetMarker.create) {
      title = "New Account";
      hideShowAppBarActions(false, false, false);
      return AccountCreateController(_widgetMarker, callback);
    } else if (_widgetMarker == WidgetMarker.detail) {
      title = "Account Detail";
      hideShowAppBarActions(false, true, false);
      //  Navigator.push(context, MaterialPageRoute(builder: (context) => AccountDetailController(widget.account, _widgetMarker, callback)));
      return AccountDetailController(widget.account, _widgetMarker, callback);
    }
    title = "Account List";
    hideShowAppBarActions(true, false, false);
    return AccountListController(_widgetMarker, callbackWithAccount);
  }
  //endregion

  //region System Callbacks
  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          Visibility(
            visible: isVisibleAdd,
            child: Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  callback(WidgetMarker.create);
                },
              ),
            ),
          ),
          Visibility(
            visible: isVisibleDelete,
            child: Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onTap: () {
                  deleteAccountDialog();
                },
              ),
            ),
          ),
          Visibility(
            visible: isVisibleEdit,
            child: Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onTap: () {
                  callback(WidgetMarker.edit);
                },
              ),
            ),
          )
        ],
      ),
      drawer: NavigationDrawer(),
      body: buildChildView(),
    );
  }
  //endregion

}
