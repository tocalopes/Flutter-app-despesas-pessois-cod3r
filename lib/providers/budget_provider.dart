import 'package:despesa_pessoal/models/budget_model.dart';
import 'package:despesa_pessoal/models/transaction_model.dart';
import 'package:despesa_pessoal/repository/budget_repository.dart';
import 'package:despesa_pessoal/repository/transaction_repository.dart';
import 'package:flutter/foundation.dart';

class BudgetProvider with ChangeNotifier {

  
  BudgetModel _budget;

  BudgetProvider(this._budget);
  
  final repo = BudgetRepository();

  double  get value {
    return _budget.value;
  }


  void update(double value) async{
    _budget.value = value;
    await repo.update(_budget);
    notifyListeners();
  }

}
