import 'package:despesa_pessoal/providers/budget_provider.dart';
import 'package:despesa_pessoal/providers/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesOverviewComponent extends StatefulWidget {
  @override
  _ExpensesOverviewComponentState createState() => _ExpensesOverviewComponentState();
}

class _ExpensesOverviewComponentState extends State<ExpensesOverviewComponent> {
  
  var editingBudget = false;

  void editBudget(){
    setState(() {
      editingBudget = true;
    });
  }

  void changeBudget(){
    setState(() {
      editingBudget = false;
    });
  }

  TextEditingController budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var budgetProvider = Provider.of<BudgetProvider>(context);
    var expensesProvider = Provider.of<ExpensesProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final backGroundColor = Colors.blue[300];
    final greenColor = Color.fromRGBO(6, 175, 47, 1);
    final redColor = Color.fromRGBO(200, 6, 6, 1);
    return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            height: screenHeight * 0.3,
            child: Column(
              children: [
                ListTile(
                  onTap: editBudget,
                    leading: Icon(
                      Icons.monetization_on,
                      color: greenColor,
                      size: 35,
                    ),
                    title: editingBudget 
                    ? TextField(
                      //controller: budgetController,
                      keyboardType: TextInputType.number,
                      onSubmitted: (value){
                        budgetProvider.update(double.parse(value));
                        changeBudget();
                      },
                    ) 
                    
                    : Text(
                      "R\$ ${budgetProvider.value}",
                      style: TextStyle(
                        fontSize: 25,
                        color: greenColor,
                      ),
                    ),
                    subtitle: Text(
                      "Orçamento",
                      style: TextStyle(color: greenColor),
                    )),
                ListTile(
                  leading: Icon(
                    Icons.money_off,
                    color: redColor,
                    size: 35,
                  ),
                  title: Text(
                    "R\$ ${expensesProvider.total}",
                    style: TextStyle(
                      fontSize: 25,
                      color: redColor,
                    ),
                  ),
                  subtitle: Text(
                    "Total Gasto",
                    style: TextStyle(color: redColor),
                  ),
                  
                ),
                ListTile(
                  leading: Icon(
                    Icons.money_off,
                    color: redColor,
                    size: 35,
                  ),
                  title: Text(
                    "R\$ ${budgetProvider.value - expensesProvider.total}",
                    style: TextStyle(
                      fontSize: 25,
                      color: redColor,
                    ),
                  ),
                  subtitle: Text(
                    "Saldo",
                    style: TextStyle(color: redColor),
                  ),
                ),
              ],
            ),
          );
  }
}