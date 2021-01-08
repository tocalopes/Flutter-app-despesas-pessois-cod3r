import 'package:sqflite/sqlite_api.dart';

enum TransactionType { UBER, FOOD, SHOPPING, BILL }

class TransactionModel {
  int id;
  String title;
  double value;
  DateTime date;
  TransactionType type;

  static final transactionTable = {
    'tableName': 'transaction_table',
    'idColumn': 'idTransaction',
    'titleColumn': 'title',
    'valueColumn': 'value',
    'dateColumn': 'date',
    'transactionTypeColumn': 'type'
  };

  TransactionModel();

  TransactionModel.toInsert(
      this.title, this.date, this.value, this.type);

  /*static List<TransactionModel> testList() {
    return [
      TransactionModel.regular( 1, 'teste 1', DateTime.now(), 12.00, TransactionType.BILL),
      TransactionModel.regular( 2, 'teste 2', DateTime.now(), 12.00, TransactionType.UBER),
      TransactionModel.regular( 3, 'teste 3', DateTime.now(), 12.00, TransactionType.FOOD),
       TransactionModel.regular( 1, 'teste 1', DateTime.now(), 12.00, TransactionType.BILL),
      TransactionModel.regular( 2, 'teste 2', DateTime.now(), 12.00, TransactionType.UBER),
      TransactionModel.regular( 3, 'teste 3', DateTime.now(), 12.00, TransactionType.FOOD),
       TransactionModel.regular( 1, 'teste 1', DateTime.now(), 12.00, TransactionType.BILL),
      TransactionModel.regular( 2, 'teste 2', DateTime.now(), 12.00, TransactionType.UBER),
      TransactionModel.regular( 3, 'teste 3', DateTime.now(), 12.00, TransactionType.FOOD),
    ];
  }*/

  Map<String, dynamic> toMap() {
    return {
      transactionTable['idColumn']: id,
      transactionTable['titleColumn']: title,
      transactionTable['valueColumn']: value,
      transactionTable['dateColumn']: date.toString(),
      transactionTable['transactionTypeColumn']: type.index
    };
  }

  TransactionModel.fromMap(Map map) {
    this.id = map[transactionTable['idColumn']];
    this.title = map[transactionTable['titleColumn']];
    this.value = map[transactionTable['valueColumn']];
    this.date = DateTime.parse(map[transactionTable['dateColumn']]);
    this.type = map[transactionTable['transactionTypeColumn']];
  }
}
