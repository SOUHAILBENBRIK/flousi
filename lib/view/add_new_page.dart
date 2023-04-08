import 'package:flousi/controller/category_controller.dart';
import 'package:flousi/model/categories.dart';
import 'package:flousi/model/money_flow.dart';
import 'package:flousi/utils/my_function.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../model/category.dart';
import '../model/sqflite/money_flow.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'category_page.dart';

class AddNewPage extends StatelessWidget {
  AddNewPage({super.key});
  final TextEditingController amount = TextEditingController();
  final TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    CategoryController provider = Provider.of<CategoryController>(context);
    // ignore: unused_local_variable
    final double height = MediaQuery.of(context).size.height;
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
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: height * 0.05),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                dropDown(context, width: width),
                const SizedBox(
                  height: 15,
                ),
                outlineButton(context, width: width),
                const SizedBox(
                  height: 10,
                ),
                StanderWidget.input(context,width,
                    controller: amount,
                    hint: AppLocalizations.of(context)!.enter_amount,
                    label: AppLocalizations.of(context)!.amount,
                    type: TextInputType.number),
                StanderWidget.input(context,width,
                    controller: description,
                    hint: AppLocalizations.of(context)!.enter_description,
                    label: AppLocalizations.of(context)!.description),
                SizedBox(
                  height: height * 0.07,
                ),
                buttonAdd(context,
                    width: width,
                    amount: amount,
                    description: description,
                    expenseOrIncome: provider.getExpenseOfIncome == 1,
                    category: provider.getCategory)
              ]),
        ),
      ),
    );
  }
}

Widget buttonAdd(BuildContext context,
    {required double width,
    required TextEditingController description,
    required TextEditingController amount,
    required Category? category,
    required bool expenseOrIncome}) {
  CategoryController provider = Provider.of<CategoryController>(context);
  return ElevatedButton(
    onPressed: () {
      if (category == null) {
        Fluttertoast.showToast(
            backgroundColor: Colors.red,
            msg: AppLocalizations.of(context)!.you_need_to_choose_category,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        MoneyFlowDatabase.instance
            .create(MoneyFlow(
                categoryName: category.name,
                categoryIconIndex: icons.indexOf(category.icon),
                amount: double.parse(amount.text),
                description: description.text,
                expenseOrIncome: expenseOrIncome,
                createdTime: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day)))
            .then((value) {
          Navigator.pushReplacementNamed(context, "/");
        });
      }
    }, 
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueGrey,
      fixedSize: Size(width * 0.8, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    ),

    child: Container(
      margin: const EdgeInsets.all(5),
      child: Text(
          "${AppLocalizations.of(context)!.add_new} ${provider.getExpenseOfIncome == 0 ? AppLocalizations.of(context)!.expense : AppLocalizations.of(context)!.income}",
          style: Theme.of(context).textTheme.displaySmall),
    ),
  );
}

Widget dropDown(BuildContext context, {required double width}) {
  CategoryController provider = Provider.of<CategoryController>(context);
  return Container(
    width: width * 0.8,
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15.0),
      border: Border.all(
          color: Theme.of(context).indicatorColor,
          style: BorderStyle.solid,
          width: 1),
    ),
    child: DropdownButton<int>(
      elevation: 0,
      isExpanded: true,
      underline: const SizedBox(),
      value: provider.getExpenseOfIncome,
      items: [
        DropdownMenuItem(
            value: 1,
            child: Text(
              AppLocalizations.of(context)!.income,
              style: Theme.of(context).textTheme.headlineSmall,
            )),
        DropdownMenuItem(
          value: 0,
          child: Text(
            AppLocalizations.of(context)!.expense,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ],
      onChanged: (value) {
        Provider.of<CategoryController>(context, listen: false)
            .setExpenseOfIncome = value!;
        debugPrint("You selected $value");
      },
    ),
  );
}

Widget outlineButton(BuildContext context, {required double width}) {
  CategoryController provider = Provider.of<CategoryController>(context);
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return CategoryPage(
              ie: Provider.of<CategoryController>(context).getExpenseOfIncome,
            );
          });
    },
    child: Container(
        width: width * 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
              color: Theme.of(context).indicatorColor,
              style: BorderStyle.solid,
              width: 1),
        ),
        child: Text(
          provider.getCategory==null?'${AppLocalizations.of(context)!.choose_Category_of} ${provider.getExpenseOfIncome == 0 ? AppLocalizations.of(context)!.expense : AppLocalizations.of(context)!.expense}':
          provider.getCategory!.name,
          style: Theme.of(context).textTheme.headlineSmall,
        )),
  );
}
