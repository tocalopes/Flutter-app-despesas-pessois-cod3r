class TransactionModel {

  int id;
  String title;
  double value;
  DateTime date;

  static final transactionTable = {
    'tableName' : 'transaction_table',
    'idColumn' : 'idTransaction',
    'titleColumn' : 'title',
    'valueColumn' : 'value',
    'dateColumn' : 'date'  
  };


  TransactionModel();

  TransactionModel.regular({
    this.id,
    this.title,
    this.date,
    this.value
  });

  Map<String,dynamic> toMap(){
    return {
      transactionTable['idColumn'] : id,
      transactionTable['titleColumn'] : title,
      transactionTable['valueColumn'] : value,
      transactionTable['dateColumn'] : date.toString(),
    };
  }

  TransactionModel.fromMap(Map map){
    this.id = map[transactionTable['idColumn']];
    this.title = map[transactionTable['titleColumn']];
    this.value = map[transactionTable['valueColumn']];
    this.date = map[transactionTable['dateColumn']];
  }
  
}
