import 'package:flousi/model/sqflite/money_flow.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/money_flow.dart';

class HomeReportPageController with ChangeNotifier {
  DateTime homePagedate = DateTime.now();
  DateTime reportPagedate = DateTime.now();
  double income = 0;
  double expence = 0;
  

  void getTotalIncome() async {
    List<MoneyFlow> myMoney = await MoneyFlowDatabase.instance.readsMoneyFlow(
        date: DateTime(homePagedate.year, homePagedate.month, homePagedate.day)
            .toIso8601String(),
        expenseOrIncome: 1);
    for (var element in myMoney) {
      income += element.amount;
    }
    notifyListeners();
  }

  void getTotalExpence() async {
    income = 0;
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
    }
    notifyListeners();
  }

  previesHomePageDay() {
    homePagedate = homePagedate.subtract(const Duration(days: 1));

    notifyListeners();
  }

  previesReportPageDay() {
    reportPagedate = reportPagedate.subtract(const Duration(days: 1));

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
      notifyListeners();
    }
  }
}
