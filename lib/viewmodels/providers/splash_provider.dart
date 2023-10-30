import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider with ChangeNotifier {
  late SharedPreferences loginData;
  late bool logged;

  void isLoggedIn(BuildContext context) async {
    loginData = await SharedPreferences.getInstance();
    logged = loginData.getBool('logged') ?? false;

    if (!logged) {
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/signup',
          (route) => false,
        );
      }
    } else {
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/homeBuilder',
          (route) => false,
        );
      }
    }
  }
}
