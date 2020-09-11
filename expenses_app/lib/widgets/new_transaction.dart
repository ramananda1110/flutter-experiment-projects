import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTxt;

  NewTransaction({this.addTxt});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectDateTime;

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount < 0 || _selectDateTime == null) {
      return;
    }

    widget.addTxt(enteredTitle, enteredAmount, _selectDateTime);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickDate) {
      if (pickDate == null) {
        return;
      }

      setState(() {
        _selectDateTime = pickDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
        child: Card(
          elevation: 5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitData(),

                // onChanged: (val) => inputTitle = val,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData,

                // onChanged: (val) => inputAmount = val,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Text(
                      _selectDateTime == null
                          ? 'No date Chosen!'
                          : 'Picked Date : ${DateFormat.yMd().format(_selectDateTime)}',
                    ),
                    FlatButton(
                      onPressed: _presentDatePicker,
                      child: Text('Choose date',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
              FlatButton(
                onPressed: () => submitData(),

                // print(titleController.text);
                // print(amountController.text
                child: Text('Add Transaction'),
                textColor: Colors.white,
                color: Colors.blueGrey,
              )
            ],
          ),
        ));
  }
}
