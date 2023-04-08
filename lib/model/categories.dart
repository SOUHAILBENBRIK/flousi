import 'package:flutter/material.dart';

import 'category.dart';

List<Category> categoriesExpense = [
  Category(id: 100, name: "Grocery", icon: Icons.local_grocery_store_outlined),
  Category(id: 101, name: "Coffee", icon: Icons.local_cafe_outlined),
  Category(id: 102, name: "Electronics", icon: Icons.desktop_windows_outlined),
  Category(id: 103, name: "Gifts", icon: Icons.card_giftcard_outlined),
  Category(id: 104, name: "Health", icon: Icons.health_and_safety_outlined),
  Category(
      id: 105, name: "Transportation", icon: Icons.directions_car_outlined),
  Category(
      id: 106, name: "Laundry", icon: Icons.local_laundry_service_outlined),
  Category(id: 107, name: "Restaurant", icon: Icons.local_dining_outlined),
  Category(id: 108, name: "Liquor", icon: Icons.liquor_outlined)
];
List<Category> categoriesIncome = [
  Category(id: 300, name: "Salary", icon: Icons.attach_money_outlined),
  Category(id: 301, name: "Gifts", icon: Icons.card_giftcard_outlined),
  Category(id: 302, name: "Wages", icon: Icons.volunteer_activism_outlined),
  Category(id: 303, name: "Interest", icon: Icons.account_balance_outlined),
  Category(id: 304, name: "allowance", icon: Icons.attach_money_outlined),
  Category(id: 305, name: "Savings", icon: Icons.savings_outlined),
];
List<IconData> icons = [
  Icons.attach_money_outlined,
  Icons.card_giftcard_outlined,
  Icons.volunteer_activism_outlined,
  Icons.account_balance_outlined,
  Icons.attach_money_outlined,
  Icons.savings_outlined,
  Icons.local_grocery_store_outlined,
  Icons.local_cafe_outlined,
  Icons.desktop_windows_outlined,
  Icons.health_and_safety_outlined,
  Icons.directions_car_outlined,
  Icons.local_laundry_service_outlined,
  Icons.local_dining_outlined,
  Icons.liquor_outlined
];
enum SystemType { pdf, currency, language }