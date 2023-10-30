import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpProvider with ChangeNotifier {
  TextEditingController? usernameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  final GlobalKey<FormState> formKey = GlobalKey();

  late SharedPreferences loginData;
  late bool newUser;

  void signUp(BuildContext context) async {
    loginData = await SharedPreferences.getInstance();
    final isValidForm = formKey.currentState!.validate();

    final String username = usernameController!.text;
    final String email = emailController!.text;
    final String password = passwordController!.text;

    if (isValidForm) {
      loginData.setString('username', username);
      loginData.setString('email', email);
      loginData.setString('password', password);
      loginData.setString('favsId', '');
      loginData.setString('favsTitle', '');
      loginData.setBool('logged', true);

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/homeBuilder',
          (route) => false,
        );
      }
    }
  }

  String? validateUsername(String? value) {
    if (value == null || value == '') return "Username is required";

    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value == '') return "Email is required";

    if (!RegExp(
      r'^[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)*$',
    ).hasMatch(value)) {
      return "Email format is incorrect";
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value == '') return "Password is required";

    if (!RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    ).hasMatch(value)) {
      return "Password must be minimum eight characters, at least one letter, one number and one special character";
    }

    return null;
  }
}
