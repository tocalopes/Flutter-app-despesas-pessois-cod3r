import 'package:despesa_pessoal/models/transaction_model.dart';
import 'package:despesa_pessoal/repository/transaction_repository.dart';
import 'package:flutter/foundation.dart';

class ExpensesProvider with ChangeNotifier {

  
  List<TransactionModel> _transactions;

  ExpensesProvider(this._transactions);
  
  final repo = TransactionRepository();

  List<TransactionModel>  get transactions {
    return [..._transactions];
  }


  void add(TransactionModel transaction) {
    print('expenses provider => ${transaction}');
    //repo.save(transaction).then((value) => null);
    _transactions.add(transaction);
    notifyListeners();
  }

  void remove(int id)  {
    repo.delete(id);
    _transactions.remove(id);
    notifyListeners();
  }
}
