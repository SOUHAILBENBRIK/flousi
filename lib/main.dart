import 'package:firebase_core/firebase_core.dart';
import 'package:flousi/controller/category_controller.dart';
import 'package:flousi/first_page.dart';
import 'package:flousi/utils/splash_screen.dart';
import 'package:flousi/view/add_new_category.dart';
import 'package:flousi/view/add_new_page.dart';
import 'package:flousi/view/init_page.dart';
import 'package:flousi/view/lock_screen.dart';
import 'package:flousi/view/manage_category.dart';
import 'package:flousi/view/search_screen.dart';
import 'package:flousi/view/sign_in_page.dart';
import 'package:flousi/view/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'controller/home_page_controller.dart';
import 'controller/my_provider.dart';
import 'controller/setting_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/l10n.dart';
import 'model/categories.dart';
import 'model/category.dart';
import 'model/sqflite/category.dart';
import 'utils/my_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MyProvider>(
        create: (_) => MyProvider(),
      ),
      ChangeNotifierProvider<CategoryController>(
        create: (_) => CategoryController(),
      ),
      ChangeNotifierProvider<HomeReportPageController>(
        create: (_) => HomeReportPageController(),
      ),
      ChangeNotifierProvider<SettingController>(
        create: (_) => SettingController(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Locale locale = Provider.of<SettingController>(context).locale??const Locale("en");

    return MaterialApp(
      locale: locale,
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      initialRoute: 'splashScreen',
      routes: {
        "splashScreen": (context) => const SplashPage(),
        '/': (context) => const FirstPage(),
        'signIn': (context) => const SignInPage(),
        'signUp': (context) => const SignUpPage(),
        'addnewcategory': (context) => NewCategory(),
        'addnewpage': (context) => AddNewPage(),
        'manageCategory': (context) => const ManageCategory(),
        'initPage': (context) => const InitPage(),
        'lockScreen': (context) => const ExampleHomePage(),
        'searchScreen': (context) => const SearchScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: Styles.themeData(false, context),
      darkTheme: Styles.themeData(true, context),
    );
  }
}
