import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveIntValue(int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('myIntValue', value);
}
Future<int> getIntValue() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int myIntValue = prefs.getInt('myIntValue') ?? 0;
  return myIntValue;
}