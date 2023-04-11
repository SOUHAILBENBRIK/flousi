import 'dart:math';

import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../controller/home_page_controller.dart';
import '../model/categories.dart';
import '../model/money_flow.dart';

class StanderWidget {
  static Widget input(BuildContext context, double width,
      {required TextEditingController controller,
      Function(String)? onChange,
      Icon? icon,
      InputBorder? border,
      required String hint,
      String? label,
      TextInputType type = TextInputType.text}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: width * 0.8,
      child: TextFormField(
        keyboardType: type,
        controller: controller,
        onChanged: onChange,
        decoration: InputDecoration(
            border: border,
            focusedBorder: border,
            enabledBorder: border,
            labelText: label,
            hintText: hint,
            prefixIcon: icon),
        validator: (value) {
          if (value!.isEmpty) {
            return AppLocalizations.of(context)!.required;
          }
          return null;
        },
      ),
    );
  }

  static Widget elementOfBlocThree(MoneyFlow money, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: generateColor(),
          child: Icon(
            icons[money.categoryIconIndex],
            color: Colors.white,
          ),
        ),
        title: Text(money.description),
        subtitle: Text(money.categoryName),
        trailing: Text(money.amount.toString()),
      ),
    );
  }

  static Widget firstBloc(BuildContext context, {required bool isHomePage}) {
    HomeReportPageController controller =
        Provider.of<HomeReportPageController>(context, listen: false);
    DateTime dateTime = isHomePage
        ? Provider.of<HomeReportPageController>(context).homePagedate
        : Provider.of<HomeReportPageController>(context).reportPagedate;
    String formattedDate = DateFormat('d MMM y').format(dateTime);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Spacer(),
          dateButton(context,
              icon: Icons.arrow_back,
              onPress: isHomePage
                  ? controller.previesHomePageDay
                  : controller.previesReportPageDay),
          const Spacer(
            flex: 2,
          ),
          GestureDetector(
            onTap: () async {
              DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: dateTime,
                  firstDate: DateTime(dateTime.year - 5),
                  lastDate: dateTime);
              controller.getTheDate(date, isHomePage);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Row(
                children: [
                  Icon(Icons.date_range, color: Theme.of(context).primaryColor),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          dateButton(context,
              icon: Icons.arrow_forward,
              onPress: isHomePage
                  ? controller.nextHomePageDay
                  : controller.nextReportPageDay),
          const Spacer()
        ],
      ),
    );
  }

  static Widget dateButton(BuildContext context,
      {required IconData icon, required Function() onPress}) {
    return IconButton(
      icon: Icon(
        icon,
        size: 25,
        color: Theme.of(context).indicatorColor,
      ),
      onPressed: onPress,
    );
  }

  static Widget authButton(BuildContext context,
      {required TextEditingController email,
      required TextEditingController password,
      required Function() onPress}) {
    return TextButton(
        style: TextButton.styleFrom(
            shape: const CircleBorder(), backgroundColor: Colors.teal),
        onPressed: onPress,
        child: const Icon(Icons.navigate_next_outlined,
            size: 40, color: Colors.white));
  }

  static Widget textButton(BuildContext context,
      {required String text, required String route}) {
    return TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, route);
        },
        child: Text(text,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  decoration: TextDecoration.underline,
                )));
  }

  static Color generateColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(100) + 156,
      random.nextInt(100) + 156,
      random.nextInt(100) + 156,
    );
  }

  static Widget empty({required String title, String? subtitle}) {
    Random random = Random();
    var list = [
      PackageImage.Image_1,
      PackageImage.Image_2,
      PackageImage.Image_3,
      PackageImage.Image_4,
    ];
    return Center(
      child: EmptyWidget(
        image: null,
        packageImage: list[random.nextInt(list.length)],
        title: title,
        subTitle: subtitle,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          color: Color(0xff9da9c7),
          fontWeight: FontWeight.w500,
        ),
        subtitleTextStyle: const TextStyle(
          fontSize: 14,
          color: Color(0xffabb8d6),
        ),
      ),
    );
  }

  static Color generateColorReport() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(200) + 55,
      random.nextInt(200) + 55,
      random.nextInt(200) + 55,
    );
  }

  static Widget outlineButton(BuildContext context,
      {required double width,
      required String text,
      required Function() function}) {
    return GestureDetector(
      onTap: function,
      child: Container(
          width: width * 0.6,
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.only(bottom: 2, top: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
                color: Theme.of(context).indicatorColor,
                style: BorderStyle.solid,
                width: 1),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          )),
    );
  }
}
