import 'package:sqflite/sqlite_api.dart';

enum TransactionType {
  UBER,
  FOOD,
  SHOPPING,
  BILL
}

class TransactionModel {

  int id;
  String title;
  double value;
  DateTime date;
  TransactionType type;

  static final transactionTable = {
    'tableName' : 'transaction_table',
    'idColumn' : 'idTransaction',
    'titleColumn' : 'title',
    'valueColumn' : 'value',
    'dateColumn' : 'date',
    'transactionTypeColumn' : 'type'
  };


  TransactionModel();

  TransactionModel.regular({
    this.id,
    this.title,
    this.date,
    this.value,
    this.type
  });

  Map<String,dynamic> toMap(){
    return {
      transactionTable['idColumn'] : id,
      transactionTable['titleColumn'] : title,
      transactionTable['valueColumn'] : value,
      transactionTable['dateColumn'] : date.toString(),
      transactionTable['transactionTypeColumn'] : type
      };
  }

  TransactionModel.fromMap(Map map){
    this.id = map[transactionTable['idColumn']];
    this.title = map[transactionTable['titleColumn']];
    this.value = map[transactionTable['valueColumn']];
    this.date = DateTime.parse(map[transactionTable['dateColumn']]);
    this.type = map[transactionTable['transactionTypeColumn']];
  }
  
}
