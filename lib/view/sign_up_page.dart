import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/my_function.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _repassword = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
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
            margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: ListView(children: [
              Form(
                  key: _formKey,
                  child: Column(children: [
                    const SizedBox(
                      height: 10,
                    ),
                    StanderWidget.input(context, width,
                        controller: _name,
                        hint: AppLocalizations.of(context)!.enter_your_name,
                        label: AppLocalizations.of(context)!.name),
                    StanderWidget.input(context, width,
                        controller: _email,
                        hint: AppLocalizations.of(context)!.enter_your_email,
                        label: AppLocalizations.of(context)!.email),
                    StanderWidget.input(context, width,
                        controller: _password,
                        hint: AppLocalizations.of(context)!.password,
                        label: AppLocalizations.of(context)!.password),
                    StanderWidget.input(context, width,
                        controller: _repassword,
                        hint: AppLocalizations.of(context)!.password,
                        label: AppLocalizations.of(context)!.confirm_password),
                  ])),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.already_have_an_account),
                  const SizedBox(
                    width: 10,
                  ),
                  StanderWidget.textButton(context,
                      text: AppLocalizations.of(context)!.signIn,
                      route: "signIn"),
                ],
              ),
              SizedBox(height: height * 0.02),
              StanderWidget.authButton(context,
                  email: _email, password: _password, onPress: () async {
                if (_password.text == _repassword.text) {
                  try {
                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _email.text, password: _password.text)
                        .then((value) {
                      Navigator.pushReplacementNamed(context, "initPage");
                    });
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
                } else {
                  Fluttertoast.showToast(
                      backgroundColor: Colors.red,
                      msg:
                          "the password and the confirm password are not the same",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  _password.clear();
                  _repassword.clear();
                }
              }),
            ])),
      ),
    );
  }
}
