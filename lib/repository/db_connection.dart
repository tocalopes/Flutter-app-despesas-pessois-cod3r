import 'package:despesa_pessoal/models/budget_model.dart';
import 'package:despesa_pessoal/models/transaction_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbConnection {
  static final transactionTable = TransactionModel.transactionTable;
  static final budgetTable = BudgetModel.budgetTable;

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "personalExpenses.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      
      List<String> creates  = [
        """CREATE TABLE ${transactionTable['tableName']} (
          ${transactionTable['idColumn']} INTEGER PRIMARY KEY AUTOINCREMENT, 
          ${transactionTable['valueColumn']} REAL,
          ${transactionTable['dateColumn']} TEXT,
          ${transactionTable['titleColumn']} TEXT,
          ${transactionTable['transactionTypeColumn']} INTEGER);""",
          """
          CREATE TABLE ${budgetTable['tableName']} (
          ${budgetTable['idColumn']} INTEGER PRIMARY KEY, 
          ${budgetTable['valueColumn']} REAL);
        """

      ];
      List<String> inserts = [
        'INSERT INTO ${budgetTable['tableName']} VALUES (1,0);'
      ];

      for(String create in creates){
        await db.execute(create);
      }

      for(String insert in inserts){
        await db.execute(insert);
      }

      
    });
  }
}
