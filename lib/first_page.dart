import 'package:firebase_auth/firebase_auth.dart';
import 'package:flousi/model/categories.dart';
import 'package:flousi/model/category.dart';
import 'package:flousi/model/sqflite/category.dart';
import 'package:flousi/view/init_page.dart';
import 'package:flousi/view/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/setting_controller.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    
    Future.delayed(const Duration(milliseconds: 500), () {
      Provider.of<SettingController>(context, listen: false).initLocale();
    });
    CategoryDatabase.instance.readsAll().then((value) {
      for (Category element in value) {
        categoriesExpense.add(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const InitPage();
          } else {
            return const SignInPage();
          }
        },
      ),
    );
  }
}
