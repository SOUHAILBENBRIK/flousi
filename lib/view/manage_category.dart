import 'package:flousi/model/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/my_function.dart';

class ManageCategory extends StatelessWidget {
  const ManageCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.manage_categories),
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "initPage");
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: ListView.builder(
              itemCount: categoriesExpense.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(categoriesExpense[index].name),
                  leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: StanderWidget.generateColor(),
                      child: Icon(categoriesExpense[index].icon)),
                );
              })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        label: Row(children: [
          const Icon(Icons.add),
          Text(AppLocalizations.of(context)!.add_new_Category),
        ]),
        onPressed: () {
          Navigator.pushNamed(context, 'addnewcategory');
        },
      ),
    );
  }
}
