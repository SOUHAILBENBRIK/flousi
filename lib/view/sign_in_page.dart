import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../model/shared_preferences/language.dart';
import '../utils/my_function.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  void initState() {
    super.initState();
    saveIntValue(0);
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    

    return Scaffold(
      body: GestureDetector(
        onTap: (() {
          FocusManager.instance.primaryFocus?.unfocus();
        }),
        child: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(top: 20),
          child: ListView(
            children: [
              CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.teal,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      "assets/icon_app.png",
                      width: 40,
                      height: 40,
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(top: height * 0.03, bottom: 20),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  child: Text(
                    "flousi",
                    style: Theme.of(context).textTheme.displayMedium,
                  )),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      StanderWidget.input(
                        context,
                        width,
                        controller: _email,
                        hint: AppLocalizations.of(context)!.enter_your_email,
                        label: AppLocalizations.of(context)!.email,
                      ),
                      StanderWidget.input(context, width,
                          controller: _password,
                          hint: AppLocalizations.of(context)!.password,
                          label: AppLocalizations.of(context)!.password),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("you don't have account ?"),
                          const SizedBox(
                            width: 10,
                          ),
                          StanderWidget.textButton(context,
                              text: AppLocalizations.of(context)!.signUp,
                              route: "signUp"),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      StanderWidget.authButton(context,
                          email: _email,
                          password: _password, onPress: () async {
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _email.text, password: _password.text);
                        } on FirebaseAuthException catch (e) {
                          Fluttertoast.showToast(
                              backgroundColor: Colors.red,
                              msg: e.message.toString(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }),
                      SizedBox(height: height * 0.04),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
