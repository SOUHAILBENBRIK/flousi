import 'package:flousi/l10n/l10n.dart';
import 'package:flousi/model/categories.dart';
import 'package:flousi/model/settings.dart';

import 'package:flutter/material.dart';

import '../model/shared_preferences/language.dart';

class SettingController with ChangeNotifier {
  late SystemType type;
  Locale _locale = const Locale("en");

  Locale get locale => _locale;
  void initLocale() async {
    int index = 0;
    getIntValue().then((value) {
      index = value;
      _locale = L10n.all[value];
      changeStateOfLanguage(index);
    });

    notifyListeners();
  }

  void setLocale(Locale locale) async {
    if (!L10n.all.contains(locale)) return;
    saveIntValue(L10n.all.indexOf(locale));
    _locale = locale;
    notifyListeners();
  }

  void changeStateOfLanguage(int index) {
    for (var element in languages) {
      element.isSelected = false;
    }
    languages[index].isSelected = true;

    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale("en");
    notifyListeners();
  }

  changeType(SystemType val) {
    type = val;
    notifyListeners();
  }
}
