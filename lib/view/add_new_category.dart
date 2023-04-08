import 'package:flousi/controller/category_controller.dart';
import 'package:flousi/model/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/my_function.dart';
import 'all_icon.dart';

class NewCategory extends StatelessWidget {
  NewCategory({super.key});
  final TextEditingController categoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CategoryController provider = Provider.of<CategoryController>(context);
    CategoryController providerFunction =
        Provider.of<CategoryController>(context, listen: false);
    final double width = MediaQuery.of(context).size.width;
    void add() {
      if (categoryController.text.isNotEmpty ||
          provider.getNewCategory?.icon != null) {
        providerFunction.setNewCategory = Category(
            id: 0,
            name: categoryController.text,
            icon: providerFunction.getNewCategory!.icon);
        providerFunction.addCategory();
        Navigator.pop(context);
      } else {
        debugPrint("sorry");
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.add_new_Category,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          const SizedBox(
            width: 8,
          ),
          CircleAvatar(
            backgroundColor: Theme.of(context).canvasColor.withOpacity(0.4),
            child: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return const AllIcon();
                    });
              },
              backgroundColor: Theme.of(context).canvasColor,
              child: Icon(providerFunction.getNewCategory?.icon ?? Icons.add),
            ),
          ),
          SizedBox(
            width: width * 0.08,
          ),
          StanderWidget.input(context, width * 0.9,
              controller: categoryController,
              hint: AppLocalizations.of(context)!.add_new_Category,
              label: AppLocalizations.of(context)!.category_Name)
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).canvasColor,
        label: Row(children: [
          const Icon(Icons.add),
          Text(AppLocalizations.of(context)!.add_the_category),
        ]),
        onPressed: add,
      ),
    );
  }
}
