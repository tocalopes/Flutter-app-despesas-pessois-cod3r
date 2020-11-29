import 'package:despesa_pessoal/components/card_list.dart';
import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionModel> transactions;
  final void Function(int) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  Text(
                    'Nenhuma Transação Cadastrada!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/julius.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : 
        
        // ListView.builder(
        //     itemCount: transactions.length,
        //     itemBuilder: (ctx, index) {
        //       final tr = transactions[index];
        //       return CardList(
        //         transaction: tr,
        //         key: GlobalObjectKey(tr),
        //         onRemove: onRemove,
        //       );
        //     },
        //   );
        ListView(
          children: transactions.map((tr){
            return CardList(
              transaction: tr,
              onRemove: onRemove,
              key: ValueKey(tr.id),
            );
          }).toList(),
        );
  }
}
