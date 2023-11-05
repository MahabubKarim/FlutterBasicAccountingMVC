import 'package:accounting/account/account.dart';
import 'package:accounting/account/account_controller.dart';
import 'package:accounting/account/account_type.dart';
import 'package:accounting/account/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';

import 'account_type_controller.dart';

class AccountTypeDetailView extends State<AccountTypeController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => AccountTypeController()));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Account Type Detail"),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AccountTypeController.edit(widget.accountType)));
                },
              ),
            )
          ],
        ),
        body: Container(
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
                      Expanded(child: Text("Account Type", textScaleFactor: 1.3)),
                      Expanded(child: Text(widget.accountType.name, textScaleFactor: 1.3)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(child: Text("Account Name", textScaleFactor: 1.3)),
                      Expanded(child: Text(widget.accountType.id.toString(), textScaleFactor: 1.3)),
                    ],
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
