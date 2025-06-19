import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seclobtechnologies_task/home_screen/controller/bottomNav_controller.dart';
import 'package:seclobtechnologies_task/home_screen/controller/homescreen_controller.dart';
import 'package:seclobtechnologies_task/login_screen/controller/login_controller.dart';
import 'package:seclobtechnologies_task/profile_screen/controller/profilescreen_controller.dart';
import 'package:seclobtechnologies_task/splash_screen/controller/onBoardingController.dart';
import 'package:seclobtechnologies_task/splash_screen/controller/splashscreen_controller.dart';

import 'package:seclobtechnologies_task/splash_screen/view/splashScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavController()),
        ChangeNotifierProvider(create: (_) => OnboardingController()),
        ChangeNotifierProvider(create: (_) => HomescreenController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => ProfilescreenController()),
        ChangeNotifierProvider(create: (_) => SplashController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Splashscreen(),
    );
  }
}
