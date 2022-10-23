import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: transactions.isEmpty
            ? Column(children: <Widget>[
                Text("No transactions added yet!",
                    style: Theme.of(context).textTheme.headline6),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ])
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).primaryColor,
                    child: Row(
                      //make the children of the row take up the entire width
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 2,
                                ),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                '\$${transactions[index].amount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //align the text to the left
                              children: <Widget>[
                                Text(
                                  transactions[index].title,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(
                                  DateFormat.yMMMd()
                                      .format(transactions[index].date),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          child: IconButton(
                            // position at the end of the row
                            icon: const Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => deleteTx(transactions[index].id),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
