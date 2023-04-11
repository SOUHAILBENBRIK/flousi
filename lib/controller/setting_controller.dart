import 'package:flousi/l10n/l10n.dart';
import 'package:flousi/model/settings.dart';

import 'package:flutter/material.dart';

import '../model/shared_preferences/language.dart';

class SettingController with ChangeNotifier {
  Locale? _locale;
  List<Language> languages = [
  Language(name: "english", isSelected: true, code: "en"),
  Language(name: "french",code: "fr",),
  Language(name: "arabic",code: "ar",)];
List<Currency> currency = [
  Currency(name: "dnt", amount: 1, isSelected: true),
  Currency(name: "dollar", amount: 3.3),
  Currency(name: "euro", amount: 3.2)
];

  Locale? get locale => _locale;
  void initLocale() {
    getIntValue().then((value) {
      _locale = L10n.all[value];
      debugPrint("$value");
      changeStateOfLanguage(value);
    });

    notifyListeners();
  }

  void setLocale(Locale locale) async {
    if (!L10n.all.contains(locale)) return;
    saveIntValue(L10n.all.indexOf(locale));
    debugPrint(L10n.all.indexOf(locale).toString());
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

  void changeStateOfCurrency(int index) {
    for (var element in currency) {
      element.isSelected = false;
    }
    currency[index].isSelected = true;
    debugPrint(index.toString());

    notifyListeners();
  }
}
