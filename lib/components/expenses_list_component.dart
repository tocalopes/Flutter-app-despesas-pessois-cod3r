import 'package:despesa_pessoal/models/transaction_model.dart';
import 'package:despesa_pessoal/providers/expenses_provider.dart';
import 'package:despesa_pessoal/repository/transaction_repository.dart';
import 'package:despesa_pessoal/utils/transaction_type_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpensesListComponent extends StatelessWidget {

  final List<TransactionModel> expenses;

  ExpensesListComponent(this.expenses);

  @override
  Widget build(BuildContext context) {
    print('buildo carai');
    for (TransactionModel tr in expenses){
      print(tr.title);
    }
   
    final backGroundColor = Colors.blue[300];
    final ExpensesProvider expenseProvider = Provider.of<ExpensesProvider>(context,listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: (Container(
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
                trailing: IconButton(
                      icon: Icon(Icons.delete_forever),
                      onPressed:() {
                        TransactionRepository().delete(expenses[index].id);
                        expenseProvider.removeAt(index);
                      }
                    ),//Text(DateFormat('dd/MM/yyyy').format(expenses[index].date)),
              ),
            );
          },
        ),
      )),
    );
 
  }
}


