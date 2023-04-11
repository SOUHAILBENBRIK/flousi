import 'package:flousi/utils/my_function.dart';
import 'package:flutter/material.dart';

class CategoryReport {
  final String name;
  final Color color = StanderWidget.generateColorReport();
  double sum ;

  CategoryReport({required this.name,this.sum=0});
}
