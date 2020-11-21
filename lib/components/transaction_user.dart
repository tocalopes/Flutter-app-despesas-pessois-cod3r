import 'dart:math';

import 'package:despesa_pessoal/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'transaction_form.dart';
import 'transaction_list.dart';

class TransactionUser extends StatefulWidget {
  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  
  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo tênis',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Cinema',
      value: 211.30,
      date: DateTime.now(),
    ),
        Transaction(
      id: 't3',
      title: 'Contra luz',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Cinema 2',
      value: 211.30,
      date: DateTime.now(),
    ),    Transaction(
      id: 't1',
      title: 'Novo tênis',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Cinema',
      value: 211.30,
      date: DateTime.now(),
    ),    Transaction(
      id: 't1',
      title: 'Novo tênis',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Cinema',
      value: 211.30,
      date: DateTime.now(),
    ),
  ];
  
  _addTransaction (String title, double value){
    final newTransaction = Transaction(
      id : Random().nextDouble().toString(),
      title: title,
      value : value,
      date : DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionForm(_addTransaction),
        TransactionList(_transactions),        
      ],
      
    );
  }
}