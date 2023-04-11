import 'package:firebase_auth/firebase_auth.dart';
import 'package:flousi/controller/setting_controller.dart';
import 'package:flousi/model/settings.dart';
import 'package:flousi/model/sqflite/category.dart';
import 'package:flousi/model/sqflite/money_flow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_theme/system_theme.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = SystemTheme.isDarkMode;
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Column(children: [
        firstBloc(context, isDark: darkMode, user: user!),
        button(context,
            icon: Icons.category_outlined,
            text: AppLocalizations.of(context)!.manage_category,
            route: 'manageCategory'),
        languageToggleButton(context,
            object: Provider.of<SettingController>(context).languages,
            name: AppLocalizations.of(context)!.choose_language),
        toggleButton(context,
            object: Provider.of<SettingController>(context).currency,
            name: AppLocalizations.of(context)!.choose_currency),
        logOutButton(context,
            icon: Icons.logout, text: AppLocalizations.of(context)!.logOut),
      ]),
    );
  }
}

Widget firstBloc(BuildContext context,
    {required bool isDark, required User user}) {
  return SafeArea(
    child: Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).highlightColor,
      padding: const EdgeInsets.all(5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(bottom: 10, top: 5),
          child: Text(AppLocalizations.of(context)!.setting,
              style: Theme.of(context).textTheme.displayLarge),
        ),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: isDark ? Colors.black : Colors.white,
              radius: 30,
              child: Icon(
                Icons.person,
                color: isDark ? Colors.blueGrey : Colors.teal,
                size: 40,
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName ??
                      user.email!.substring(0, user.email!.indexOf("@")),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(user.email!,
                    style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        )
      ]),
    ),
  );
}

Widget button(BuildContext context,
    {required IconData icon, required String text, required String route}) {
  return ListTile(
    onTap: () => Navigator.pushReplacementNamed(context, route),
    leading: Icon(icon),
    title: Text(text),
    trailing: const Icon(Icons.navigate_next_outlined),
  );
}

Widget logOutButton(BuildContext context,
    {required IconData icon, required String text}) {
  return ListTile(
    onTap: () async {
      FirebaseAuth.instance.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('myIntValue', 0);
      MoneyFlowDatabase.instance.clearDatabase();
      CategoryDatabase.instance.clearDatabase();
      //Navigator.pushReplacementNamed(context, "");
    },
    leading: Icon(icon),
    title: Text(
      text,
      style: Theme.of(context).textTheme.labelLarge,
    ),
  );
}

Widget languageToggleButton(BuildContext context,
    {required List<Language> object, required String name}) {
  final darkMode = SystemTheme.isDarkMode;
  return Container(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        ToggleButtons(
            onPressed: (index) {
              Provider.of<SettingController>(context, listen: false)
                  .setLocale(Locale(object[index].code));
              Provider.of<SettingController>(context, listen: false)
                  .changeStateOfLanguage(index);
            },
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            selectedColor: darkMode ? Colors.white : Colors.black,
            fillColor: darkMode ? Colors.blueGrey : Colors.teal,
            //color: darkMode ? Colors.red : Colors.green,
            isSelected: object.map((e) => e.isSelected).toList(),
            children: object
                .map((e) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(e.name),
                    ))
                .toList()),
        const SizedBox(
          width: 10,
        )
      ],
    ),
  );
}

Widget toggleButton(BuildContext context,
    {required List<Currency> object, required String name}) {
  final darkMode = SystemTheme.isDarkMode;
  return Container(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        ToggleButtons(
            onPressed: Provider.of<SettingController>(context, listen: false).changeStateOfCurrency,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            selectedColor: darkMode ? Colors.white : Colors.black,
            fillColor: darkMode ? Colors.blueGrey : Colors.teal,
            //color: darkMode ? Colors.red : Colors.green,
            isSelected: object.map((e) => e.isSelected).toList(),
            children: object
                .map((e) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(e.name),
                    ))
                .toList()),
        const SizedBox(
          width: 10,
        )
      ],
    ),
  );
}
