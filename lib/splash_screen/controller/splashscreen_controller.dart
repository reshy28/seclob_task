import 'package:flutter/material.dart';
import 'package:seclobtechnologies_task/home_screen/view/bottombar.dart';
import 'package:seclobtechnologies_task/splash_screen/view/onBoardingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController with ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> checkLoginStatus(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    await Future.delayed(const Duration(seconds: 2)); // optional splash delay

    if (token != null && token.isNotEmpty) {
      _isLoggedIn = true;
      notifyListeners();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomBar()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    }
  }
}
