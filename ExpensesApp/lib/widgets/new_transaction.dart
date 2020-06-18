import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
  final Function add;

  NewTransaction(this.add);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = new TextEditingController();

  final _amountController = new TextEditingController();

  DateTime _selectedDate;
  void addTransaction() {
    if(_amountController.text.isEmpty){
      return ;
    }
    String title = _titleController.text;
    double amount = double.parse(_amountController.text);
    print(title);
    if (title.isEmpty || amount <= 0 || _selectedDate==null) return;

    widget.add(title, amount,_selectedDate);
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 19,
          color: Colors.black.withOpacity(0.6),
          spreadRadius: 0,
          offset: Offset(0, 3),
        )
      ]),
      child: Card(
        elevation: 4,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => addTransaction(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => addTransaction(),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                                      child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text(
                        _selectedDate!=null?'Picked date :${DateFormat.yMMMd().format(_selectedDate)}':'No date Choosen',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text('Choose Date',
                          style: TextStyle(
                            color: Colors.blue,
                          )),
                    ),
                    onPressed: () {
                      _datePicker();
                      
                    },
                    
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  color: Colors.blueAccent,
                  child: Text(
                    'Add Transcation',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: addTransaction,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
