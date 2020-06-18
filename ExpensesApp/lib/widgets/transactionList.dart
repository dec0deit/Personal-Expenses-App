import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function _deleteTransaction;
  TransactionList(this.transaction,this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transaction.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('No Transactions yet',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Container(
                    width: double.infinity,
                    height: 200,
                    child: Container(
                      child: Image.asset(
                        'asset/images/index.jpeg',
                        fit: BoxFit.contain,
                      ),
                    ))
              ],
            )
          : ListView.builder(
              itemCount: transaction.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.all(10),
                                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      foregroundColor: Colors.white,
                      child: FittedBox(
                        child: Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Text(
                            '${transaction[index].amount.toStringAsFixed(2)}\$',
                          ),
                        ),
                      ),
                    ),
                    title:Text('${transaction[index].title}',style: Theme.of(context).textTheme.title,),
                    subtitle: Text('${DateFormat.yMMMd().format(transaction[index].time)}'),
                    trailing: IconButton(
                      icon:Icon(Icons.delete),
                      color:Theme.of(context).errorColor,
                      onPressed: (){
                        _deleteTransaction(transaction[index].id);
                      },

                    ),
                  ),
                );
              },
            ),
    );
  }
}
