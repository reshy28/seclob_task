import 'package:flutter/material.dart';
import 'package:seclobtechnologies_task/login_screen/view/login_screen.dart';

class OnboardingController extends ChangeNotifier {
  final PageController pageController = PageController();
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void nextPage() {
    if (_currentPage < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void goToLogin(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  void onPageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
