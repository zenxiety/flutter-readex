import 'package:flutter/material.dart';
import 'package:flutter_manga_app_test/views/screens/home/home_screen.dart';
import 'package:flutter_manga_app_test/views/screens/home/profile_screen.dart';
import 'package:flutter_manga_app_test/views/screens/home/recommendation_screen.dart';

class HomeBuilderProvider with ChangeNotifier {
  int selectedIndex = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const RecommendationScreen(),
    const ProfileScreen(),
  ];

  void selectScreen(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
