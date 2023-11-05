import 'package:accounting/account/account_controller.dart';
import 'package:accounting/account/account_type_controller.dart';
import 'package:accounting/account/general_ledger_controller.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                child: Center(
                  child: Text('Accounting',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700, fontSize: 30.0)),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView(padding: EdgeInsets.only(top: 0), children: [
              ListTile(
                title: Text("Account"),
                leading: Icon(
                  Icons.list,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .push(new PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
                    return AccountController();
                  }, transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                    return new FadeTransition(opacity: animation, child: child);
                  }));
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => AccountController()));
                },
              ),
              ListTile(
                title: Text("Account Type"),
                leading: Icon(
                  Icons.list,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.pop(context);
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => AccountTypeController()));
                  Navigator.of(context)
                      .push(new PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
                    return AccountTypeController();
                  }, transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                    return new FadeTransition(opacity: animation, child: child);
                  }));
                },
              ),
              ListTile(
                title: Text("General Ledger"),
                leading: Icon(
                  Icons.list,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.pop(context);
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => AccountTypeController()));
                  Navigator.of(context)
                      .push(new PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
                    return GeneralLedgerController();
                  }, transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                    return new FadeTransition(opacity: animation, child: child);
                  }));
                },
              ),
            ]),
          )
        ],
      ),
    );
  }
}
