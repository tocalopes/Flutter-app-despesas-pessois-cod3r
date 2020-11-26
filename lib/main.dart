import 'dart:math';
import 'dart:io';

import 'package:despesa_pessoal/components/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

import 'components/chart.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]
    );*/
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple, //range de cores
        accentColor: Colors.purple[300],
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
            ),
            button:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20, //* mediaQuery.textScaleFactor,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    //   id: 't0',
    //   title: 'Conta antiga',
    //   value: 310.76,
    //   date: DateTime.now().subtract(Duration(days: 33)),
    // ),
    /*Transaction(
      id: 't1',
      title: 'Novo tênis',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Cinema',
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't3',
      title: 'Cinema',
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't4',
      title: 'Cinema',
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't5',
      title: 'Cinema',
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: 't6',
      title: 'Cinema',
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 0)),
    ),
    Transaction(
      id: 't7',
      title: 'Cinema',
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),*/
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((t) {
      return t.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    Widget _getIconButton(IconData icon, Function fn) {
      return Platform.isIOS
          ? GestureDetector(onTap: fn, child: Icon(icon))
          : IconButton(icon: Icon(icon), onPressed: fn);
    }

    final actions = [
      if (isLandscape)
        _getIconButton(
          _showChart ? Icons.list : Icons.show_chart,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
      ),
    ];

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Desepesas Pessoais'),
            trailing: Row(
              children: actions,
              mainAxisSize: MainAxisSize.min,
            ),
          )
        : AppBar(
            title: Text(
              "Despesas Pessoais",
            ),
            actions: actions,
          );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final page = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLandscape)
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Exebir gráfico'),
                Switch.adaptive(
                  activeColor: Theme.of(context).accentColor,
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                ),
              ],
            ),*/
            if (_showChart || !isLandscape)
              Container(
                height: availableHeight * (isLandscape ? 0.8 : 0.25),
                child: Chart(_recentTransactions),
              ),
          if (!_showChart || !isLandscape)
            Container(
              height: availableHeight * (isLandscape ? 1 : 0.75),
              child: TransactionList(_transactions, _removeTransaction),
            ),
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: page,
          )
        : Scaffold(
            appBar: appBar,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _openTransactionFormModal(context),
                    child: Icon(Icons.add),
                  ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: page,
          );
  }
}
