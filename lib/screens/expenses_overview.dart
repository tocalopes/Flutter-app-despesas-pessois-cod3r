import 'package:despesa_pessoal/components/expenses_list_component.dart';
import 'package:despesa_pessoal/components/expenses_overview_component.dart';
import 'package:despesa_pessoal/models/transaction_model.dart';
import 'package:despesa_pessoal/utils/transaction_type_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensesOverview extends StatefulWidget {
  @override
  _ExpensesOverviewState createState() => _ExpensesOverviewState();
}

class _ExpensesOverviewState extends State<ExpensesOverview> {
  
  PersistentBottomSheetController _controllerBottomSheet; // <------ Instance variable
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

          List<String> listTypes = ['One', 'Two', 'Free', 'Four'];
          String dropdownValue = listTypes[0];

          void changeDropDownItem(String item) {
            setState(() {
              dropdownValue = item;
            });
          }

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Descrição',
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: valueController,
                    decoration: InputDecoration(
                      labelText: 'Valor',
                    ),
                  ),
                  FormField(
                    builder: (ctx) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('dd/MM/yyyy')
                                .format(DateTime.now())
                                .toString(),
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]),
                          ),
                          FlatButton(
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2021),
                                lastDate: DateTime(2022),
                              );
                            },
                            child: Text('selecione uma data'),
                            color: Colors.blueGrey,
                          ),
                        ],
                      );
                    },
                  ),
                  DropdownButton<String>(
                    value: '$dropdownValue',
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      changeDropDownItem(newValue);
                    },
                    items: listTypes
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: FlatButton(
                      onPressed: () {
                        print(
                            'Desc: ${titleController.text.toString()}, price: R\$${valueController.text.toString()}, date: ${dateController.text.toString()}');
                      },
                      child: Text('Cadastrar'),
                      color: Colors.blue[300],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final backGroundColor = Colors.blue[300];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final expenses = TransactionModel.testList();
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
            context, titleController, valueController, dateController),
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
