import 'dart:math';

import 'package:flousi/controller/category_controller.dart';
import 'package:flousi/model/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/categories.dart';

class AllIcon extends StatelessWidget {
  const AllIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.5,
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35))),
      child: ListView.builder(
        itemCount: (icons.length / 4).ceil(),
        itemBuilder: (context, index) {
          int startIndex = index * 4;
          int endIndex = startIndex + 4;
          if (endIndex > icons.length) endIndex = icons.length;
          List<Widget> rowChildren = icons
              .sublist(startIndex, endIndex)
              .map((e) => button(context, icon: e))
              .toList();
          return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: rowChildren);
        },
      ),
    );
  }
}

Widget button(BuildContext context, {required IconData icon}) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    child: FloatingActionButton(
      onPressed: () {
        Provider.of<CategoryController>(context, listen: false).setNewCategory =
            Category(
                id: 0,
                name: Provider.of<CategoryController>(context, listen: false)
                        .getNewCategory
                        ?.name ??
                    "",
                icon: icon);
        Navigator.pop(context);
      },
      backgroundColor: generateColor(),
      elevation: 0,
      child: Icon(icon, color: Theme.of(context).primaryColor),
    ),
  );
}

Color generateColor() {
  Random random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(100) + 156,
    random.nextInt(100) + 156,
    random.nextInt(100) + 156,
  );
}
