import 'package:despesa_pessoal/models/transaction_model.dart';
import 'package:despesa_pessoal/repository/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class TransactionRepository {
  static final dbConnection = DbConnection();
  final table = TransactionModel.transactionTable['tableName']; 

  Future<void> save(TransactionModel transaction) async {
    final Database db = await dbConnection.db;
    transaction.id = await db.insert(
      table,
      transaction.toMap(),
    );
    return transaction;
  }

  Future<List<TransactionModel>> getAll() async {
    Database db = await dbConnection.db;
    List listMap = await db.rawQuery("SELECT * FROM $table");
    List<TransactionModel> listModel = List();
    for(Map m in listMap){
      listModel.add(TransactionModel.fromMap(m));
    }
    return listModel;
  }


}
