import 'package:flousi/controller/home_page_controller.dart';
import 'package:flousi/model/sqflite/money_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../utils/my_function.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeReportPageController>(context, listen: false)
        .getTotalExpence();
    Provider.of<HomeReportPageController>(context, listen: false)
        .getTotalIncome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.currency_exchange_outlined),
        title: Text(
          "flousi",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        actions: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "searchScreen");
                  },
                  icon: const Icon(Icons.search))),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: SingleChildScrollView(
            child: Column(
          children: [
            StanderWidget.firstBloc(context, isHomePage: true),
            secondBloc(context),
            thirdBloc(context),
            thirdBloc(context, expenceOrIncome: 1)
          ],
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        label: Row(children: [
          const Icon(Icons.add),
          Text(AppLocalizations.of(context)!.add_new),
        ]),
        onPressed: () {
          Navigator.pushNamed(context, 'addnewpage');
        },
      ),
    );
  }
}

Widget secondBloc(BuildContext context) {
  HomeReportPageController provider =
      Provider.of<HomeReportPageController>(context);
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6),
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
    decoration: BoxDecoration(
      border: Border.all(
        style: BorderStyle.solid,
        color: Theme.of(context).highlightColor,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
    ),
    child: Row(children: [
      const Spacer(
        flex: 1,
      ),
      elementOfBlocTwo(context,
          icon: Icons.attach_money_outlined,
          name: AppLocalizations.of(context)!.expense,
          amount: provider.expence),
      const Spacer(
        flex: 3,
      ),
      elementOfBlocTwo(context,
          icon: Icons.account_balance_outlined,
          name: AppLocalizations.of(context)!.balence,
          amount: provider.income - provider.expence),
      const Spacer(
        flex: 3,
      ),
      elementOfBlocTwo(context,
          icon: Icons.account_balance_wallet_outlined,
          name: AppLocalizations.of(context)!.income,
          amount: provider.income),
      const Spacer(
        flex: 1,
      ),
    ]),
  );
}

Widget thirdBloc(BuildContext context, {int expenceOrIncome = 0}) {
  HomeReportPageController controller =
      Provider.of<HomeReportPageController>(context);
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      width: width,
      height: height * 0.4,
      decoration: BoxDecoration(
        border: Border.all(
          style: BorderStyle.solid,
          color: Theme.of(context).highlightColor,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: FutureBuilder(
        future: MoneyFlowDatabase.instance.readsMoneyFlow(
            date: DateTime(controller.homePagedate.year,
                    controller.homePagedate.month, controller.homePagedate.day)
                .toIso8601String(),
            expenseOrIncome: expenceOrIncome),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Text(AppLocalizations.of(context)!.loading);
          } else if (snapShot.hasError) {
            return Text(AppLocalizations.of(context)!.somthing_wrong_happend);
          } else if (snapShot.hasData) {
            if (snapShot.data!.isEmpty) {
              return StanderWidget.empty(
                  title: expenceOrIncome == 0
                      ? AppLocalizations.of(context)!.empty_expense_List
                      : AppLocalizations.of(context)!.empty_income_List);
            } else {
              return ListView.builder(
                itemCount: snapShot.data!.length,
                itemBuilder: (context, index) {
                  return StanderWidget.elementOfBlocThree(
                      snapShot.data![index], true);
                },
              );
            }
          } else {
            return const Text("shit");
          }
        },
      ));
}

Widget elementOfBlocTwo(BuildContext context,
    {required IconData icon, required String name, required double amount}) {
  return Column(
    children: [
      Icon(
        icon,
        color: Theme.of(context).indicatorColor,
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        name,
        style: TextStyle(color: Theme.of(context).indicatorColor, fontSize: 12),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        amount.toStringAsFixed(0),
        style: TextStyle(
            color: amount < 0 ? Colors.red : Theme.of(context).indicatorColor,
            fontSize: 12),
      ),
    ],
  );
}
