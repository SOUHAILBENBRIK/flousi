import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../controller/home_page_controller.dart';
import '../model/sqflite/money_flow.dart';
import '../utils/my_function.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

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
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_outlined))
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
            secondBloc(context),
            const SizedBox(
              height: 20,
            ),
            thirdBloc(context),
          ],
        )),
      ),
    );
  }
}

Widget thirdBloc(BuildContext context, {int expenceOrIncome = 0}) {
  HomeReportPageController controller =
      Provider.of<HomeReportPageController>(context);
  return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(
          style: BorderStyle.solid,
          color: Theme.of(context).highlightColor,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: FutureBuilder(
        future: MoneyFlowDatabase.instance.readsMoneyFlow(
            date: controller.homePagedate.toIso8601String(),
            expenseOrIncome: expenceOrIncome),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Text(AppLocalizations.of(context)!.loading);
          } else if (snapShot.hasError) {
            return Text(AppLocalizations.of(context)!.somthing_wrong_happend);
          } else if (snapShot.hasData) {
            if (snapShot.data!.isEmpty) {
              return const Text("there is no element yet ");
            } else {
              return ListView.builder(
                itemCount: snapShot.data!.length,
                itemBuilder: (context, index) {
                  return StanderWidget.elementOfBlocThree(
                      snapShot.data![index],true);
                },
              );
            }
          } else {
            return const Text("shit");
          }
        },
      ));
}

Widget secondBloc(BuildContext context) {
  final GlobalKey<AnimatedCircularChartState> chartKey =
      GlobalKey<AnimatedCircularChartState>();
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  return Container(
    margin: EdgeInsets.symmetric(vertical: height * 0.08),
    padding: const EdgeInsets.all(3),
    child: AnimatedCircularChart(
      key: chartKey,
      size: Size(width * 0.8, height * 0.15),
      initialChartData: <CircularStackEntry>[
        CircularStackEntry(
          <CircularSegmentEntry>[
            CircularSegmentEntry(
              30,
              Colors.blue[400],
              rankKey: 'completed',
            ),
            const CircularSegmentEntry(
              10,
              Colors.pink,
            ),
            const CircularSegmentEntry(
              10,
              Colors.yellow,
            ),
            const CircularSegmentEntry(
              10,
              Colors.green,
            ),
            const CircularSegmentEntry(
              40,
              Colors.red,
            ),
          ],
          rankKey: 'progress',
        ),
      ],
      chartType: CircularChartType.Radial,
      percentageValues: true,
      holeLabel: '1/3',
      labelStyle: TextStyle(
        color: Colors.blueGrey[600],
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
      ),
    ),
  );
}
