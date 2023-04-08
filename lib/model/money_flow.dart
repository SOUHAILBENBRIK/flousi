const String tableMoneyFlow = 'moneyFlowTable';

class MoneyFlowFields {
  static final List<String> values = [
    id,
    categoryName,
    amount,
    categoryIconIndex,
    description,
    createdTime,
    expenseOrIncome
  ];
  static const String id = '_id';
  static const String categoryIconIndex = 'categoryIconIndex';
  static const String createdTime = 'createdTime';
  static const String amount = 'amount';
  static const String description = 'description';
  static const String expenseOrIncome = 'expenseOrIncome';
  static const String categoryName = 'categoryName';
}

class MoneyFlow {
  final int? id;
  final int categoryIconIndex;
  final String categoryName;
  final DateTime createdTime;
  final double amount;
  final String description;
  final bool expenseOrIncome;
  MoneyFlow(
      {this.id,
      required this.categoryName,
      required this.categoryIconIndex,
      required this.amount,
      required this.description,
      required this.expenseOrIncome,
      required this.createdTime});
  Map<String, Object?> toJson() => {
        MoneyFlowFields.id: id,
        MoneyFlowFields.categoryName: categoryName,
        MoneyFlowFields.amount: amount,
        MoneyFlowFields.categoryIconIndex: categoryIconIndex,
        MoneyFlowFields.description: description,
        MoneyFlowFields.createdTime: createdTime.toIso8601String(),
        MoneyFlowFields.expenseOrIncome:
            expenseOrIncome ? 1 : 0, //si 1 Expense else income
      };
  static MoneyFlow fromJson(Map<String, Object?> json) => MoneyFlow(
      //id: json[MoneyFlowFields.categoryIconIndex] as String,
      categoryIconIndex: json[MoneyFlowFields.categoryIconIndex] as int,
      categoryName: json[MoneyFlowFields.categoryName] as String,
      amount: json[MoneyFlowFields.amount] as double,
      description: json[MoneyFlowFields.description] as String,
      expenseOrIncome: json[MoneyFlowFields.expenseOrIncome] == 1
          ? true
          : false, //si 1 Expense else income
      createdTime: DateTime.parse(json[MoneyFlowFields.createdTime] as String));
  MoneyFlow copy({
    required int? id,
    int? categoryIconIndex,
    String? categoryName,
    DateTime? createdTime,
    double? amount,
    String? description,
    bool? expenseOrIncome,
  }) {
    return MoneyFlow(
        categoryName: categoryName ?? this.categoryName,
        categoryIconIndex: categoryIconIndex ?? this.categoryIconIndex,
        amount: amount ?? this.amount,
        description: description ?? this.description,
        expenseOrIncome: expenseOrIncome ?? this.expenseOrIncome,
        createdTime: createdTime ?? this.createdTime);
  }
}
