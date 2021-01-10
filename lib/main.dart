import 'package:despesa_pessoal/models/budget_model.dart';
import 'package:despesa_pessoal/models/transaction_model.dart';
import 'package:despesa_pessoal/providers/budget_provider.dart';
import 'package:despesa_pessoal/providers/expenses_provider.dart';
import 'package:despesa_pessoal/repository/budget_repository.dart';
import 'package:despesa_pessoal/repository/transaction_repository.dart';
import 'package:despesa_pessoal/screens/expenses_overview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatefulWidget {
  @override
  _ExpensesAppState createState() => _ExpensesAppState();
}

class _ExpensesAppState extends State<ExpensesApp> {
  //List<TransactionModel> transactionList = [];

  var budget;
  Future<List<TransactionModel>> getAllTransactions() async {
    var transactionList = await TransactionRepository().getAll();
    await getBudget();
    return transactionList;
  }

  Future<void> getBudget() async {
    budget = await BudgetRepository().getFirst();
    return budget;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllTransactions(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var transactionList = snapshot.data;
          if(snapshot.hasData){
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => new ExpensesProvider(transactionList),
              ),
              ChangeNotifierProvider(
                create : (_) => new BudgetProvider(budget),
              ),
            ],
            child: MaterialApp(
              home: ExpensesOverview(),
              theme: ThemeData(
                primarySwatch: Colors.blueGrey,
                accentColor: Color.fromRGBO(20, 130, 181, 1.0),
                fontFamily: 'Quicksand',
                textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      button: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                appBarTheme: AppBarTheme(
                  textTheme: ThemeData.light().textTheme.copyWith(
                        headline6: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                ),
              ),
            ),
          );
        }else{
          return CircularProgressIndicator();
        }
        });
  }
}
