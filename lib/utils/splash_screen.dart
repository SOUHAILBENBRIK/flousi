


import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flousi/first_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
          'assets/icon_app.png'),
      title: const Text(
        "Flousi",
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      ),
      backgroundColor: Colors.teal,
      showLoader: false,
      navigator: const FirstPage(),
      durationInSeconds: 2,
    );
  }
}