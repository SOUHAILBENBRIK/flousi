import 'package:shared_preferences/shared_preferences.dart';

import '../lock.dart';

Future<void> saveLock(Lock lock) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('lock_passcode', lock.passcode);
  await prefs.setBool('lock_isEnabled', lock.isEnabled);
}

// create a method to retrieve an instance of Lock
Future<Lock> getLock() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String passcode = prefs.getString('lock_passcode') ?? '';
  bool isEnabled = prefs.getBool('lock_isEnabled') ?? false;
  Lock lock = Lock(passcode: passcode, isEnabled: isEnabled);
  return lock;
}