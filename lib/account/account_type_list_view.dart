import 'package:accounting/account/account_type.dart';
import 'package:flutter/material.dart';

import 'account_type_controller.dart';
import 'widgets/navigation_drawer.dart';

class AccountTypeListView extends State<AccountTypeController> {
  List<AccountType> accountTypes = List();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  void updateListView() {
    widget.list.then((list) => {
      if (list != null) {
          setState(() {
            accountTypes = list;
          })
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Type List"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AccountTypeController.create()));
              },
            ),
          )
        ],
      ),
      drawer: NavigationDrawer(),
      body: Builder(
        builder: (context) => Padding(
            padding: EdgeInsets.all(5),
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: accountTypes.length,
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
                                accountTypes[position].name,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              subtitle: Text(accountTypes[position].id.toString()),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AccountTypeController.detail(accountTypes[position])));
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ))),
      ),
    );
  }
}
