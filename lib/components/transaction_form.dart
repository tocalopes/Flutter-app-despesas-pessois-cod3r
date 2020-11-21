import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionForm extends StatefulWidget {
  
  
  final void Function(String,double) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm(){
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0){
      return;
    }

    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [                  
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Título',
                    ),
                    onSubmitted: (_) => _submitForm(),
                  ),                  
                  TextField(
                    controller: valueController,
                    decoration: InputDecoration(
                      labelText: 'Valor R\$',
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal :true),
                    onSubmitted: (_) => _submitForm(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                        child: Text("Nova Transação"),
                        onPressed: () {
                          _submitForm();
                        },
                        textColor: Colors.purple,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}