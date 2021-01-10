import 'package:despesa_pessoal/models/budget_model.dart';
import 'package:despesa_pessoal/repository/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class BudgetRepository {
  DbConnection dbConnection = DbConnection();
  final table = BudgetModel.budgetTable['tableName'];

  Future<void> update(BudgetModel model) async {
    final Database db = await dbConnection.db;
    model.id = await db.update(table, model.toMap());
    return model;
  }

  Future<List<BudgetModel>> getAll() async {
    Database db = await dbConnection.db;
    List listMap = await db.rawQuery("SELECT * FROM $table");
    List<BudgetModel> listModel = List();
    for (Map m in listMap) {
      listModel.add(BudgetModel.fromMap(m));
    }
    return listModel;
  }

  Future<BudgetModel> getFirst() async {
    List<BudgetModel> list = await getAll();
    return list.first;
  }
}
