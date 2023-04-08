import 'package:flousi/view/home_page.dart';
import 'package:flousi/view/report_page.dart';
import 'package:flousi/view/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
   @override
  void initState() {
    super.initState();
    
  }
  int _currentIndex = 1;
  List<Widget> list = const  [
    ReportPage(),
    HomePage(),
    SettingPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (value) {
            // Respond to item press.
            setState(() => _currentIndex = value);
          },
          items: [
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.report,
              icon: const Icon(Icons.pie_chart_outline_outlined),
            ),
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.home,
              icon: const Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.setting,
              icon: const Icon(Icons.settings),
            ),
          ]),
    );
  }
}
