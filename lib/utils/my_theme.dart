import 'package:flutter/material.dart';


class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    Color primaryColor = isDarkTheme ? Colors.white : Colors.blueGrey;
    Color titleColor = isDarkTheme ? Colors.white : Colors.black;
    return ThemeData(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme: const IconThemeData(size: 25),
        selectedLabelStyle: const TextStyle(fontSize: 15),
        unselectedIconTheme: const IconThemeData(size: 20),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedItemColor: isDarkTheme?Colors.white:Colors.blueGrey,
        selectedItemColor: Colors.teal,
        backgroundColor:  isDarkTheme ?Colors.black : Colors.white,
      ),
      
      primaryColor: isDarkTheme ? Colors.black : Colors.white,
      canvasColor: isDarkTheme ? Colors.blueGrey : Colors.white,
      scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.white,
      indicatorColor: titleColor,
      hintColor: isDarkTheme ? const Color(0xff280C0B) : const Color(0xffEECED3),
      highlightColor: isDarkTheme ? Colors.grey : Colors.blueGrey,
      hoverColor: isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
      focusColor: isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
      
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? const ColorScheme.dark() : const ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        iconTheme: IconThemeData(color: titleColor)
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
            fontSize: 28, color: titleColor, fontWeight: FontWeight.w400),
        displayMedium: TextStyle(
            fontSize: 24, color: titleColor, fontWeight: FontWeight.w400),
        displaySmall: TextStyle(
            fontSize: 20, color: titleColor, fontWeight: FontWeight.w400),
        headlineMedium: const TextStyle(fontSize: 18, color: Colors.teal),
        headlineSmall: TextStyle(fontSize: 16, color: titleColor),
        titleLarge: TextStyle(fontSize: 14, color: titleColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorStyle: const TextStyle(color: Colors.blueGrey),
          filled: true,
          labelStyle: TextStyle(color: titleColor),
          hintStyle: TextStyle(color: Colors.grey[800]),
          fillColor: isDarkTheme?Colors.black:Colors.white),
    );
  }
}
