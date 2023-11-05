import 'package:accounting/account/general_ledger_controller.dart';
import 'package:accounting/account/transaction.dart';
import 'package:accounting/account/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GeneralLedgerView extends State<GeneralLedgerController> {
  void updateListView() {
    List<Transaction> transactions = widget.listTransactions();
    setState(() {
      widget.list = transactions;
      widget.count = transactions.length;
    });
  }

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("General Ledger"),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: GestureDetector(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onTap: () {},
                ),
              )
            ],
          ),
          drawer: NavigationDrawer(),
          body: ListView.builder(
            itemCount: widget.count,
            itemBuilder: (BuildContext context, int position) {
              return Card(
                color: Colors.white,
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(child: Text("Account Name", textScaleFactor: 1.3)),
                          SizedBox(width: 10),
                          Expanded(child: new Text(widget.list[position].accountId.toString(),
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.subtitle1
                          )),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child: Text("Balance", textScaleFactor: 1.3)),
                          SizedBox(width: 10),
                          Expanded(child: new Text(widget.list[position].balance.toString(),
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.subtitle1
                          )),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child: Text("Date", textScaleFactor: 1.3)),
                          SizedBox(width: 10),
                          Expanded(child: new Text(
                              "${DateFormat('dd MMM, yyyy').format(widget.list[position].date).toString()}",
                              style: Theme.of(context).textTheme.subtitle1
                          )),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child: Row(
                            children: <Widget>[
                              Expanded(child: Text("Debit", textScaleFactor: 1.2,)),
                              Expanded(child: new Text(widget.list[position].debit.toString(),
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context).textTheme.subtitle1
                              )),
                            ],
                          )),
                          SizedBox(width: 10),
                          Expanded(child: Row(
                            children: <Widget>[
                              Expanded(child: Text("Credit", textScaleFactor: 1.2,)),
                              Expanded(child: new Text(widget.list[position].credit.toString(),
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context).textTheme.subtitle1
                              )),
                            ],
                          ),),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
