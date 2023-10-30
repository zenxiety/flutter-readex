import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/viewmodels/providers/splash_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      final provider = Provider.of<SplashProvider>(context, listen: false);
      provider.isLoggedIn(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/logo.png'),
            Text(
              "Readex",
              style: Theme.of(context).textTheme.titleLarge!,
            ),
          ],
        ),
      ),
    );
  }
}
