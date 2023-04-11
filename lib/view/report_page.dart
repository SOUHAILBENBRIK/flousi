import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../controller/home_page_controller.dart';
import '../utils/my_function.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomeReportPageController>(context, listen: false)
        .getCategoryReportIncome();
    Provider.of<HomeReportPageController>(context, listen: false)
        .getCategoryReportExpence();
  }

  @override
  Widget build(BuildContext context) {
    HomeReportPageController provider =
        Provider.of<HomeReportPageController>(context);
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.currency_exchange_outlined),
        title: Text(
          "flousi",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        actions: const [
          /*IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_outlined))*/
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: SingleChildScrollView(
            child: Column(
          children: [
            StanderWidget.firstBloc(context, isHomePage: false),
            const SizedBox(
              height: 20,
            ),
            provider.categoriesReportIncome.isEmpty?StanderWidget.empty(title:AppLocalizations.of(context)!.empty_income_List):incomeBloc(context, provider),
            const SizedBox(
              height: 20,
            ),
            provider.categoriesReportExpence.isEmpty?StanderWidget.empty(title: AppLocalizations.of(context)!.empty_expense_List):expenceBloc(context, provider),
          ],
        )),
      ),
    );
  }
}

Widget incomeBloc(BuildContext context, HomeReportPageController provider) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 3),
    child: Card(
      color: Theme.of(context).primaryColor,
      elevation: 10,
      shadowColor: Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(
    side: const BorderSide(color: Colors.white70, width: 1),
    borderRadius: BorderRadius.circular(20),
  ),
      child: Container(
        height: height*0.55,
        padding: const EdgeInsets.all(3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.income,style: Theme.of(context).textTheme.displaySmall,),
            SizedBox(
              height: height * 0.3,
              width: width * 0.7,
              child: PieChart(PieChartData(
                centerSpaceRadius: 60,
                sectionsSpace: 0,
                borderData: FlBorderData(show: false),
                sections: getSectionsIncome(context, provider),
              )),
            ),
            SizedBox(
              height: height * 0.2,
              width: width * 0.8,
              child: ListView.builder(
                itemCount: (provider.categoriesReportIncome.length / 2).ceil(),
                itemBuilder: (context, index) {
                  int startIndex = index * 2;
                  int endIndex = startIndex + 2;
                  if (endIndex > provider.categoriesReportIncome.length) {
                    endIndex = provider.categoriesReportIncome.length;
                  }
                  List<Widget> rowChildren = provider.categoriesReportIncome
                      .sublist(startIndex, endIndex)
                      .map((e) => Container(
                            margin: const EdgeInsets.all(10),
                            child: SizedBox(
                              width: width * 0.3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: e.color,
                                    radius: 10,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(e.name,style: Theme.of(context).textTheme.labelSmall,),
                                ],
                              ),
                            ),
                          ))
                      .toList();
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: rowChildren);
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget expenceBloc(BuildContext context, HomeReportPageController provider) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 3),
    child: Card(
      color: Theme.of(context).primaryColor,
      elevation: 10,
      shadowColor: Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(
    side: const BorderSide(color: Colors.white70, width: 1),
    borderRadius: BorderRadius.circular(20),
  ),
      child: Container(
        height: height*0.55,
        padding: const EdgeInsets.all(3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.expense,style: Theme.of(context).textTheme.displaySmall,),
            SizedBox(
              height: height * 0.3,
              width: width * 0.7,
              child: PieChart(PieChartData(
                centerSpaceRadius: 60,
                sectionsSpace: 0,
                borderData: FlBorderData(show: false),
                sections: getSectionsExpence(context, provider),
              )),
            ),
            SizedBox(
              height: height * 0.2,
              width: width * 0.8,
              child: ListView.builder(
                itemCount: (provider.categoriesReportExpence.length / 2).ceil(),
                itemBuilder: (context, index) {
                  int startIndex = index * 2;
                  int endIndex = startIndex + 2;
                  if (endIndex > provider.categoriesReportExpence.length) {
                    endIndex = provider.categoriesReportExpence.length;
                  }
                  List<Widget> rowChildren = provider.categoriesReportExpence
                      .sublist(startIndex, endIndex)
                      .map((e) => Container(
                            margin: const EdgeInsets.all(10),
                            child: SizedBox(
                              width: width * 0.3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: e.color,
                                    radius: 10,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(e.name,style: Theme.of(context).textTheme.labelSmall,),
                                ],
                              ),
                            ),
                          ))
                      .toList();
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: rowChildren);
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

List<PieChartSectionData> getSectionsIncome(
        BuildContext context, HomeReportPageController provider) =>
    provider.categoriesReportIncome
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
          final value = PieChartSectionData(
              color: data.color,
              value: data.sum,
              title:
                  "${((data.sum / provider.income) * 100).toStringAsFixed(0)}%",
              titleStyle: Theme.of(context).textTheme.headlineSmall);
          return MapEntry(index, value);
        })
        .values
        .toList();
List<PieChartSectionData> getSectionsExpence(
        BuildContext context, HomeReportPageController provider) =>
    provider.categoriesReportExpence
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
          final value = PieChartSectionData(
              color: data.color,
              value: data.sum,
              title:
                  "${((data.sum / provider.expence) * 100).toStringAsFixed(0)}%",
              titleStyle: Theme.of(context).textTheme.headlineSmall);
          return MapEntry(index, value);
        })
        .values
        .toList();
