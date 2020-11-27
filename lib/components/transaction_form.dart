import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'adaptative_button.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double,DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _valueController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text.replaceAll(',', '.')) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value,_selectedDate);
  }

  _showDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),      
    ).then((pickedDate){
      if(pickedDate == null){
        return;
      }
      setState(() {
        _selectedDate = pickedDate;  
      });      
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Título',
                ),
                onSubmitted: (_) => _submitForm(),
              ),
              TextField(
                controller: _valueController,
                decoration: InputDecoration(
                  labelText: 'Valor R\$',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                        _selectedDate == null ? 'Nenhuma data selecionada'
                        : 'Data: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',                      
                      ),
                    ),
                    FlatButton(
                      onPressed: _showDatePicker,
                      child: Text(
                        'Selecionar uma data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                    label: 'Nova Transação',
                    onPressed: _submitForm(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
