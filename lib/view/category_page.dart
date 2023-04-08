
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flousi/controller/category_controller.dart';
import 'package:flousi/model/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/categories.dart';
import '../utils/my_function.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.ie});
  final int ie;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    void nextPage() {
      Navigator.pushReplacementNamed(context, 'addnewcategory');
    }

    // ignore: unused_local_variable
    final double width = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
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
        itemCount:
            ((widget.ie == 0 ? categoriesExpense : categoriesIncome).length / 3)
                .ceil(),
        itemBuilder: (context, index) {
          int startIndex = index * 3;
          int endIndex = startIndex + 3;
          List<Category> categories =
              widget.ie == 0 ? categoriesExpense : categoriesIncome;
          if (endIndex > categories.length) endIndex = categories.length;
          List<Widget> rowChildren = categories
              .sublist(startIndex, endIndex)
              .map((e) => button(context, category: e))
              .toList();
          return endIndex < categories.length
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: rowChildren)
              : Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: rowChildren),
                  const SizedBox(
                    height: 5,
                  ),
                  widget.ie == 0
                      ? StanderWidget.outlineButton(context,
                          width: width,
                          text: AppLocalizations.of(context)!.add_new_Category,
                          function: nextPage)
                      : const SizedBox()
                ]);
        },
      ),
    );
  }
}

Widget button(BuildContext context, {required Category category}) {
  CategoryController provider =
      Provider.of<CategoryController>(context, listen: false);
  return Container(
    margin: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        FloatingActionButton(
          onPressed: () {
            provider.setCategory = category;
            Navigator.pop(context);
          },
          backgroundColor: StanderWidget.generateColor(),
          elevation: 0,
          child: Icon(
            category.icon,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          category.name,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 10),
        ),
      ],
    ),
  );
}


