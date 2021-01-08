import 'package:despesa_pessoal/models/transaction_model.dart';
import 'package:despesa_pessoal/repository/transaction_repository.dart';
import 'package:flutter/foundation.dart';

class ExpensesProvider with ChangeNotifier {
  TransactionRepository repo = new TransactionRepository();
  List<TransactionModel> _transactions;

  Future<List<TransactionModel>> get transactions async{
    _transactions = await repo.getAll();
    return [..._transactions];
  }

  void add(TransactionModel transaction) async {
    await repo.save(transaction);
    _transactions.add(transaction);
    notifyListeners();
  }

  void remove(int id) async {
    await repo.delete(id);
    _transactions.remove(id);
    notifyListeners();
  }
}
