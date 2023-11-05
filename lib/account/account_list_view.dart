import 'package:accounting/account/account.dart';
import 'package:accounting/account/account_controller.dart';
import 'package:accounting/account/account_view.dart';
import 'package:accounting/account/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';

import 'account_list_controller.dart';

class AccountListView extends State<AccountListController> {

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

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: widget.count,
            itemBuilder: (BuildContext context, int position) {
              return Card(
                color: Colors.white,
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          widget.list[position].name,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        subtitle: Text(widget.list[position].code),
                        onTap: () {
                          widget.callbackWithAccount(widget.list[position], WidgetMarker.detail);
                          /*Navigator.pop(context);
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => AccountController.detail(widget.list[position])));*/
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
