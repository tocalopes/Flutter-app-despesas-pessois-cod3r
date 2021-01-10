import 'package:despesa_pessoal/models/transaction_model.dart';
import 'package:despesa_pessoal/repository/transaction_repository.dart';
import 'package:flutter/foundation.dart';

class ExpensesProvider with ChangeNotifier {
  List<TransactionModel> _transactions;

  ExpensesProvider(this._transactions);

  final repo = TransactionRepository();

  List<TransactionModel> get transactions {
    return [..._transactions];
  }

  double get total {
    return _transactions.fold(0, (acc, transaction) => acc + transaction.value);
  }

  void add(TransactionModel transaction) {
    //repo.save(transaction).then((value) => null);
    _transactions.add(transaction);
    notifyListeners();
  }

  void removeAt(int index) {
    _transactions.removeAt(index);
    notifyListeners();
  }
}
