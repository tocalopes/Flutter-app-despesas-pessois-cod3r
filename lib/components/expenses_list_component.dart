import 'package:despesa_pessoal/models/transaction_model.dart';
import 'package:despesa_pessoal/providers/expenses_provider.dart';
import 'package:despesa_pessoal/utils/transaction_type_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesListComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final backGroundColor = Colors.blue[300];
    final ExpensesProvider expenseProvider = Provider.of<ExpensesProvider>(context);
    final Future<List<TransactionModel>> expensesFuture = expenseProvider.transactions;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: FutureBuilder(
          future: expensesFuture,
          builder: (BuildContext context, AsyncSnapshot<List<TransactionModel>> snapshot){
            if(snapshot.hasData){
              var expenses = snapshot.data; 
              return Container(
          height: screenHeight * 0.4,
          child: ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenWidth * 0.01,
                ),
                child: ListTile(
                  leading: TransactionTypeIcons.getIcon(expenses[index].type),
                  title: Text('R\$ ${expenses[index].value.toString()}'),
                  subtitle: Text(expenses[index].title),
                ),
              );
            },
          ),
        );
        }else{
          return Container(child: Text('no data'),);
        }
          },   ),
    );
  }
}
