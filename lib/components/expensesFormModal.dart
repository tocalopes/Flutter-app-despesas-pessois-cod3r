import 'package:despesa_pessoal/models/transaction_model.dart';
import 'package:despesa_pessoal/providers/expenses_provider.dart';
import 'package:despesa_pessoal/repository/transaction_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpensesFormModal extends StatefulWidget {
  @override
  _ExpensesFormModalState createState() => _ExpensesFormModalState();

  TextEditingController titleController;
  TextEditingController valueController;
  TextEditingController dateController;

  ExpensesFormModal(
    this.titleController,
    this.valueController,
    this.dateController,
  );
}

class _ExpensesFormModalState extends State<ExpensesFormModal> {
  @override
  List<String> listTypes = ['Compras','Comida',  'Contas','Uber'];
  String dropdownValue;

  void changeDropDownItem(String item) {    
    setState(() {
      dropdownValue = item;
    });
  }

  TransactionType getTransactionType() {
    if (dropdownValue == 'Uber') {
      return TransactionType.UBER;
    }
    if (dropdownValue == 'Comida') {
      return TransactionType.FOOD;
    }
    if (dropdownValue == 'Compras') {
      return TransactionType.SHOPPING;
    }
    if (dropdownValue == 'Contas') {
      return TransactionType.BILL;
    }
    return TransactionType.BILL;
  }

  DateTime _selectedDate;
  Widget build(BuildContext context) {
    final ExpensesProvider expenseProvider =
        Provider.of<ExpensesProvider>(context, listen: false);
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              keyboardType: TextInputType.text,
              controller: widget.titleController,
              decoration: InputDecoration(
                labelText: 'Descrição',
              ),
            ),
            TextField(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              keyboardType: TextInputType.number,
              controller: widget.valueController,
              decoration: InputDecoration(
                labelText: 'Valor',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (_selectedDate != null) ? DateFormat('dd/MM/yyyy').format(_selectedDate) : '...',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                FlatButton(
                  onPressed: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2022),
                    ).then((pickedDate) => {
                          setState(() {
                            _selectedDate = pickedDate;
                          })
                        });
                  },
                  child: Text('selecione uma data'),
                  color: Colors.blueGrey,
                ),
              ],
            ),
            DropdownButton<String>(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              value: dropdownValue == null ? listTypes[0] : '$dropdownValue',
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
              items: listTypes.map<DropdownMenuItem<String>>((String value) {
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
                onPressed: () async {
                  TransactionModel transactionModel = TransactionModel();
                  transactionModel.title = widget.titleController.text;
                  transactionModel.value =
                      double.parse(widget.valueController.text);
                  transactionModel.date = _selectedDate;
                  transactionModel.type = getTransactionType();
                  var fodase =
                      await TransactionRepository().save(transactionModel);
                  expenseProvider.add(fodase);
                  Navigator.of(context).pop();
                },
                child: Text('Cadastrar'),
                color: Colors.blue[300],
              ),
            )
          ],
        ),
      ),
    );
  }
}
