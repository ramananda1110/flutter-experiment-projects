import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'new_transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _transactions = [
    Transaction(
        id: "t1", title: "New shoes", amount: 12.3, date: new DateTime.now()),
    Transaction(
        id: "t2", title: "Groceries", amount: 50.90, date: new DateTime.now()),
    Transaction(
        id: "t3", title: "Shopping", amount: 14.6, date: new DateTime.now()),

  ];

  void _addNewTransaction(String txtTitle, double txtAmount) {
    final newTxt = Transaction(
        title: txtTitle,
        amount: txtAmount,
        id: DateTime.now().toString(),
        date: DateTime.now());

    setState(() {
      _transactions.add(newTxt);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(addTxt: _addNewTransaction),
       // TransactionList(_transactions),
      ],
    );
  }
}
