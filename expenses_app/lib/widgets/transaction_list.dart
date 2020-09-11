import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,

      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text('\৳${transactions[index].amount}'),
                  ),
                ),
              ),
              title: Text(
                transactions[index].title,
                style: Theme.of(context).textTheme.title,
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(transactions[index].date),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTx(transactions[index].id),
              ),
            ),
          );
        },

        /* return Card(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    )),
                    padding: EdgeInsets.all(4),
                    child: Text(
                        '\৳${transactions[index].amount.toStringAsFixed(2)}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(transactions[index].title,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                          //Text(DateFormat('yyyy/MM/dd').format(tx.date),
                          Text(
                              DateFormat.MMMEd()
                                  .format(transactions[index].date),
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                        ]),
                  )
                ],
              ),
            ),
          );*/

        itemCount: transactions.length,
      ),

      // child: SingleChildScrollView(
      //child: Column(
    );

/*child: ListView(children: transactions.map((tx) {
          // ui body added
        }).toList()));
    */
  }
}
