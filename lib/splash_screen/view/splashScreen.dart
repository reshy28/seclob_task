import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seclobtechnologies_task/splash_screen/controller/splashscreen_controller.dart';
import 'package:seclobtechnologies_task/constants/images.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    final splashController = Provider.of<SplashController>(
      context,
      listen: false,
    );
    splashController.checkLoginStatus(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Image.asset(AppImages.spalshscreenImage, fit: BoxFit.fill),
      ),
    );
  }
}
