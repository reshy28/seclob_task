import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seclobtechnologies_task/splash_screen/controller/onBoardingController.dart';
import 'package:seclobtechnologies_task/constants/colors.dart';
import 'package:seclobtechnologies_task/constants/images.dart';

class OnboardingScreen extends StatelessWidget {
  final List<Map<String, dynamic>> onboardingPages = [
    {
      "title": "Welcome to",
      "highlight": "Seclob",
      "description":
          "Start growing your business with our platform — track sales, manage clients, and maximize profits.",
      "image": AppImages.onBoarding1,
    },
    {
      "title": "Manage Your Partners",
      "highlight": "Seamlessly",
      "description":
          "Add, view, and collaborate with your team or resellers,\nall from a single dashboard.",
      "image": AppImages.onBoarding2,
    },
    {
      "title": "Analyze & Boost Your",
      "highlight": "Earnings",
      "description":
          "Get real-time reports, track performance, and maximize incentives with ease.",
      "image": AppImages.onBoarding3,
    },
  ];

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingController(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<OnboardingController>(
          builder: (context, state, child) {
            return Stack(
              children: [
                // Page View
                PageView(
                  controller: state.pageController,
                  onPageChanged: state.onPageChanged,
                  children: onboardingPages
                      .map((page) => _buildPageContent(context, page))
                      .toList(),
                ),

                // Page Indicators
                Positioned(
                  bottom: 90,
                  left: 0,
                  right: 0,
                  child: _buildPageIndicators(state),
                ),

                // Navigation Button
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: _buildNavigationButton(context, state),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPageContent(BuildContext context, Map<String, dynamic> page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          // Title
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              page["title"],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          // Highlighted text
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.purple.shade300,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  page["highlight"],
                  style: const TextStyle(
                    color: Color(0xff491B6D),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Description
          Text(
            page["description"],
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.grey[700], fontSize: 12),
          ),
          // Image
          Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(page["image"]),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildPageIndicators(OnboardingController state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onboardingPages.length,
        (index) => _buildPageIndicator(index, state.currentPage),
      ),
    );
  }

  Widget _buildPageIndicator(int index, int currentPage) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: index == currentPage ? 16 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: index == currentPage
            ? AppColors.primary
            : AppColors.indicatorBagroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildNavigationButton(
    BuildContext context,
    OnboardingController state,
  ) {
    final isLastPage = state.currentPage == onboardingPages.length - 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton(
        onPressed: () {
          if (isLastPage) {
            state.goToLogin(context);
          } else {
            state.nextPage();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff491B6D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(
          isLastPage ? "Sign in" : "Next",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
