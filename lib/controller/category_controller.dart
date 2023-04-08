import 'package:flousi/model/category.dart';
import 'package:flousi/model/sqflite/category.dart';
import 'package:flutter/material.dart';

import '../model/categories.dart';

class CategoryController with ChangeNotifier {
  int _expenseOrIncome = 0; //par default expense
  Category? _newCategory;
  Category? _category;
  int get getExpenseOfIncome => _expenseOrIncome;

  set setExpenseOfIncome(int value) {
    _expenseOrIncome = value;
    notifyListeners();
  }

  set setNewCategory(Category category) {
    _newCategory = Category(
        id: 100 + categoriesExpense.length,
        name: category.name,
        icon: category.icon);
    notifyListeners();
  }

  Category? get getNewCategory => _newCategory;
  set setCategory(Category category) {
    _category =
        Category(id: category.id, name: category.name, icon: category.icon);
    notifyListeners();
  }

  Category? get getCategory => _category;

  void addCategory() {
    Category? x = getNewCategory!;
    categoriesExpense.add(x);
    CategoryDatabase.instance.create(x);
    setNewCategory =
        Category(id: 100 + categoriesExpense.length, name: "", icon: Icons.add);
    x = getNewCategory!;
    debugPrint("done");
    notifyListeners();
  }
}
