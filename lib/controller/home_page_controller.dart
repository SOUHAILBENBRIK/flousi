import 'package:flousi/model/report_page_model.dart';
import 'package:flousi/model/sqflite/money_flow.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/money_flow.dart';

class HomeReportPageController with ChangeNotifier {
  DateTime homePagedate = DateTime.now();
  DateTime reportPagedate = DateTime.now();
  double income = 0;
  double expence = 0;
  List<CategoryReport> categoriesReportIncome = [];
  List<CategoryReport> categoriesReportExpence = [];

  void getTotalIncome() async {
    income = 0;
    List<MoneyFlow> myMoney = await MoneyFlowDatabase.instance.readsMoneyFlow(
        date: DateTime(homePagedate.year, homePagedate.month, homePagedate.day)
            .toIso8601String(),
        expenseOrIncome: 1);
    for (var element in myMoney) {
      income += element.amount;
    }
    notifyListeners();
  }

  bool checkList(
      {required List<CategoryReport> list, required String variable}) {
    for (var i in list) {
      if (i.name == variable) {
        return true;
      }
    }
    return false;
  }

  void getCategoryReportIncome() async {
    categoriesReportIncome = [];
    List<MoneyFlow> myMoney = await MoneyFlowDatabase.instance.readsMoneyFlow(
        date: DateTime(
                reportPagedate.year, reportPagedate.month, reportPagedate.day)
            .toIso8601String(),
        expenseOrIncome: 1);
    for (var element in myMoney) {
      if (checkList(
          list: categoriesReportIncome, variable: element.categoryName)) {
        categoriesReportIncome[categoriesReportIncome.indexWhere(
                (element1) => element.categoryName == element1.name)]
            .sum += element.amount;
      } else {
        final CategoryReport categoryReport =
            CategoryReport(name: element.categoryName, sum: element.amount);
        categoriesReportIncome.add(categoryReport);
      }
    }
    notifyListeners();
  }

  void getCategoryReportExpence() async {
    categoriesReportExpence = [];
    List<MoneyFlow> myMoney = await MoneyFlowDatabase.instance.readsMoneyFlow(
        date: DateTime(
                reportPagedate.year, reportPagedate.month, reportPagedate.day)
            .toIso8601String(),
        expenseOrIncome: 0);
    for (var element in myMoney) {
      if (checkList(
          list: categoriesReportExpence, variable: element.categoryName)) {
        categoriesReportExpence[categoriesReportExpence.indexWhere(
                (element1) => element.categoryName == element1.name)]
            .sum += element.amount;
      } else {
        final CategoryReport categoryReport =
            CategoryReport(name: element.categoryName, sum: element.amount);
        categoriesReportExpence.add(categoryReport);
      }
    }
    notifyListeners();
  }

  void getTotalExpence() async {
    expence = 0;
    List<MoneyFlow> myMoney = await MoneyFlowDatabase.instance.readsMoneyFlow(
        date: DateTime(homePagedate.year, homePagedate.month, homePagedate.day)
            .toIso8601String(),
        expenseOrIncome: 0);
    for (var element in myMoney) {
      expence += element.amount;
    }
    notifyListeners();
  }

  getTheDate(DateTime? value, bool isHomePage) {
    if (isHomePage) {
      homePagedate = value ?? DateTime.now();
    } else {
      reportPagedate = value ?? DateTime.now();
      getCategoryReportExpence();
      getCategoryReportIncome();
    }
    notifyListeners();
  }

  previesHomePageDay() {
    homePagedate = homePagedate.subtract(const Duration(days: 1));

    notifyListeners();
  }

  previesReportPageDay() {
    reportPagedate = reportPagedate.subtract(const Duration(days: 1));
    getCategoryReportExpence();
      getCategoryReportIncome();

    notifyListeners();
  }

  nextHomePageDay() {
    if (homePagedate.year == DateTime.now().year &&
        homePagedate.month == DateTime.now().month &&
        homePagedate.day == DateTime.now().day) {
      Fluttertoast.showToast(
          backgroundColor: Colors.red,
          msg: "you can't do that",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      homePagedate = homePagedate.add(const Duration(days: 1));

      notifyListeners();
    }
  }

  nextReportPageDay() {
    if (reportPagedate.year == DateTime.now().year &&
        reportPagedate.month == DateTime.now().month &&
        reportPagedate.day == DateTime.now().day) {
      Fluttertoast.showToast(
          backgroundColor: Colors.red,
          msg: "you can't do that",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      reportPagedate = reportPagedate.add(const Duration(days: 1));
      getCategoryReportExpence();
      getCategoryReportIncome();
      notifyListeners();
    }
  }
}
