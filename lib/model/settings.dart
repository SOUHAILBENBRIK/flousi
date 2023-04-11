const String tableLanguage = 'Language';

class LanguageFields {
  static final List<String> values = [
    code,
    name,
    isSelected,
  ];
  static const String id = '_id';
  static const String name = 'name';
  static const String code = 'code';
  static const String isSelected = "isSelected";
}

class Language {
  int id;
  String name;
  String code;
  bool isSelected;

  Language({this.id=1,required this.name, this.isSelected = false, required this.code});

  Map<String, Object?> toJson() => {
        LanguageFields.id:1,
        LanguageFields.name: name,
        LanguageFields.code: code,
        LanguageFields.isSelected: isSelected ? 1 : 0,
      };
  static Language fromJson(Map<String, Object?> json) => Language(
        id: 1,
        name: json[LanguageFields.name] as String,
        code: json[LanguageFields.code] as String,
        isSelected: json[LanguageFields.isSelected] == 1 ? true : false,
      );
}

class Currency {
  String name;
  bool isSelected;
  double amount;

  Currency({required this.name, this.isSelected = false, this.amount = 0});
}


