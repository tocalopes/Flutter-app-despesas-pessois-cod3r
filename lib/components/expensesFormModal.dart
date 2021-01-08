import 'package:despesa_pessoal/models/transaction_model.dart';
import 'package:despesa_pessoal/providers/expenses_provider.dart';
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
  List<String> listTypes = ['Uber', 'Comida', 'Compras', 'Contas'];
  String dropdownValue;

  void changeDropDownItem(String item) {
    print('$item');
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
    return null;
  }

  DateTime _selectedDate;
  Widget build(BuildContext context) {
    final ExpensesProvider expenseProvider =
        Provider.of<ExpensesProvider>(context);
    print('PROVIDER: $expenseProvider');
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              autofocus: true,
              keyboardType: TextInputType.text,
              controller: widget.titleController,
              decoration: InputDecoration(
                labelText: 'Descrição',
              ),
            ),
            TextField(
              autofocus: true,
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
                  _selectedDate.toString(),
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                FlatButton(
                  onPressed: () {
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
                  print(
                      'Desc: ${widget.titleController.text.toString()}, price: R\$${widget.valueController.text.toString()}, date: ${_selectedDate.toString()}, type: ${getTransactionType()}');
                  print('PROVIDER: $expenseProvider');
                  TransactionModel transactionModel = TransactionModel();
                  print(transactionModel);
                  transactionModel.title = widget.titleController.text;
                  transactionModel.value =
                      double.parse(widget.valueController.text);
                  transactionModel.date = _selectedDate;
                  transactionModel.type = getTransactionType();
                  await expenseProvider.add(transactionModel);                  
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
