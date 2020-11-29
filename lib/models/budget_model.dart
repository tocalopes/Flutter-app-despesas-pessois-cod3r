class BudgetModel {

  int id;
  double value;
  static final budgetTable = {
    "tableName" : "budget_table",
    "idColumn" : "id_budget",
    "valueColumn" : "value"
  };

  BudgetModel();

  BudgetModel.fromMap(Map map){
    this.id = map[budgetTable['idColumn']];
    this.value = map[budgetTable['valueColumn']];
  }

  Map<String,dynamic> toMap(){
    return {
      budgetTable['idColumn'] : this.id,
      budgetTable['valueColumn'] : this.value
    };
  }
}