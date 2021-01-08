import 'package:despesa_pessoal/components/expensesFormModal.dart';
import 'package:despesa_pessoal/components/expenses_list_component.dart';
import 'package:despesa_pessoal/components/expenses_overview_component.dart';
import 'package:despesa_pessoal/models/transaction_model.dart';
import 'package:despesa_pessoal/providers/expenses_provider.dart';
import 'package:despesa_pessoal/utils/transaction_type_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpensesOverview extends StatefulWidget {
  @override
  _ExpensesOverviewState createState() => _ExpensesOverviewState();
}

class _ExpensesOverviewState extends State<ExpensesOverview> {
  PersistentBottomSheetController
      _controllerBottomSheet; // <------ Instance variable
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openTransactionFormModal(
    BuildContext context,
    TextEditingController titleController,
    TextEditingController valueController,
    TextEditingController dateController,
  ) {
    print('asda');
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return ExpensesFormModal(
              titleController, valueController, dateController);
        });
  }

  @override
  Widget build(BuildContext context) {
    final backGroundColor = Colors.blue[300];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final TextEditingController titleController = new TextEditingController();
    final TextEditingController valueController = new TextEditingController();
    final TextEditingController dateController = new TextEditingController();
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Gaste menos!'),
        backgroundColor: backGroundColor,
      ),
      floatingActionButton: IconButton(
        onPressed: () => _openTransactionFormModal(
          context,
          titleController,
          valueController,
          dateController,
        ),
        icon: Container(
          child: Icon(
            Icons.add,
            size: 34,
            color: Colors.black,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
        color: Colors.white,
      ),
      body: Column(
        children: [
          ExpensesOverviewComponent(),
          Container(
            width: screenWidth * 0.15,
            height: screenWidth * 0.15,
            margin: EdgeInsets.only(
              bottom: screenHeight * 0.01,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              Icons.arrow_downward_outlined,
              color: backGroundColor,
            ),
          ),
          ExpensesListComponent(),
        ],
      ),
    );
  }
}
