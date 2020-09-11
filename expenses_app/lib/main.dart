import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal expresses',
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.purple,
          primaryColor: Colors.blue,
          // errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    /* Transaction(
        id: "t1", title: "New shoes", amount: 12.3, date: new DateTime.now()),
    Transaction(
        id: "t2", title: "Groceries", amount: 50.90, date: new DateTime.now()),
    Transaction(
        id: "t3", title: "Shopping", amount: 14.6, date: new DateTime.now()),*/
  ];

  void _addNewTransaction(
      String txtTitle, double txtAmount, DateTime chooseDate) {
    final newTxt = Transaction(
        title: txtTitle,
        amount: txtAmount,
        id: DateTime.now().toString(),
        date: chooseDate);

    setState(() {
      _transactions.add(newTxt);
    });
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return NewTransaction(addTxt: _addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("Expenses app"),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context))
      ],
    );

    return MaterialApp(
      title: 'Personal expresses',
      home: Scaffold(
          appBar: appBar,
          body: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Container(
                child: _transactions.isEmpty
                    ? Container(
                        width: double.infinity,
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.75,
                        child: Image.asset(
                          'assets/images/ic_no_transaction.png',
                          fit: BoxFit.cover,
                        ))
                    : Container(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.25,
                        child: Chart(_recentTransactions),
                      ),
              ),
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.75,
                  child: TransactionList(_transactions, _deleteTransaction))
            ],
          )),
          //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )),
    );
  }
}
