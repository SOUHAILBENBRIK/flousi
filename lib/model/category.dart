import 'package:flutter/material.dart';

import 'categories.dart';

const String tableCategory = 'category';

class CategoryFields {
  static final List<String> values = [
    id,
    name,
    icon,
  ];
  static const String id = '_id';
  static const String name = 'name';
  static const String icon = "icon";

}
class Category {
  int? id;
  String name;
  IconData icon;
  Category({this.id, required this.name, required this.icon});
  Map<String, Object?> toJson() => {
        CategoryFields.id: id,
       CategoryFields.name: name,
       CategoryFields.icon: icons.indexOf(icon),
      };
  static Category fromJson(Map<String, Object?> json) => Category(
      id: json[CategoryFields.id] as int,
      name: json[CategoryFields.name] as String,
      icon: icons[json[CategoryFields.icon] as int],);
  Category copy({
    int? id,
    String? name,
    IconData? icon,
  }) =>
      Category(
          id: id ?? this.id,
          name: name ?? this.name,
          icon:  icon?? this.icon,
          );

}

