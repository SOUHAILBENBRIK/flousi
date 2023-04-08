import 'package:flousi/model/categories.dart';
import 'package:flousi/model/money_flow.dart';
import 'package:flousi/utils/my_function.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/sqflite/money_flow.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<MoneyFlow> moneyFlowList = [];
  List<MoneyFlow> moneyFlowListFiltred = [];
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    MoneyFlowDatabase.instance.readSearchMoneyFlow().then((value) {
      moneyFlowList = value;
      moneyFlowListFiltred = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SizedBox(
                width: width,
                height: height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, "initPage");
                            },
                            icon: const Icon(Icons.arrow_back)),
                        StanderWidget.input(
                          context,
                          width,
                          onChange: searchMoneyFlow,
                          controller: _search,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hint: AppLocalizations.of(context)!
                              .write_category_name_or_description,
                        )
                      ]),
                      SizedBox(
                        width: width,
                        height: height * 0.8,
                        child: ListView.builder(
                            itemCount: moneyFlowListFiltred.length,
                            itemBuilder: (context, index) {
                              final moneyFlow = moneyFlowListFiltred[index];
                              final String formatDate = DateFormat('d MMM y')
                                  .format(moneyFlow.createdTime);
                              return ListTile(
                                title: Text(moneyFlow.description),
                                trailing: Text(
                                  "${moneyFlow.expenseOrIncome ? "-" : ""} ${moneyFlow.amount}",
                                  style: TextStyle(
                                      color: moneyFlow.expenseOrIncome
                                          ? Colors.red
                                          : Theme.of(context).indicatorColor),
                                ),
                                subtitle: Text(formatDate),
                                leading: CircleAvatar(
                                    radius: 20,
                                    backgroundColor:
                                        StanderWidget.generateColor(),
                                    child:
                                        Icon(icons[moneyFlow.categoryIconIndex])),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void searchMoneyFlow(String value) {
    final moneyFlowFx = moneyFlowList.where((element) {
      final money = element.description.toLowerCase();
      final input = value.toLowerCase();
      return money.contains(input);
    }).toList();
    setState(() {
      moneyFlowListFiltred = moneyFlowFx;
    });
  }
}
