import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:seclobtechnologies_task/home_screen/controller/homescreen_controller.dart';
import 'package:seclobtechnologies_task/profile_screen/controller/profilescreen_controller.dart';
import 'package:seclobtechnologies_task/constants/colors.dart';
import 'package:seclobtechnologies_task/constants/images.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _carouselImages = [
    AppImages.carouselImage,
    AppImages.carouselImage,
    AppImages.carouselImage,
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<HomescreenController>();
      final profilecontroller = context.read<ProfilescreenController>();
      controller.fetchUserData();
      controller.fetchBalance();
      profilecontroller.fetchProfileDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Consumer<HomescreenController>(
              builder: (context, controller, child) {
                if (controller.isLoading && controller.userName == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.errorMessage != null) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      controller.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                return Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.homeBackground),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hey ${controller.userName ?? 'User'} 👋",
                              style: const TextStyle(
                                fontSize: 23,
                                color: Colors.black,
                              ),
                            ),
                            const Icon(
                              IconlyLight.notification,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Available balance",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        controller.isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                "₹${controller.balanceAmount}",
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text(
                            "Add",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Carousel Slider
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: _carouselImages.length,
                    itemBuilder: (context, index, realIdx) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          _carouselImages[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 120,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      viewportFraction: 0.95,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayInterval: const Duration(seconds: 4),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Services",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      customServiceCard(AppImages.serviceECard, size),
                      const SizedBox(width: 16),
                      customServiceCard(AppImages.serviceHRInsight, size),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      customServiceCard(
                        AppImages.serviceRecharge,
                        size,
                        label: "Get 10% Extra",
                      ),
                      const SizedBox(width: 16),
                      customServiceCard(AppImages.serviceDTH, size),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Container(
                    height: size.height * 0.18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(AppImages.referFriend),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customServiceCard(String imagePath, Size size, {String? label}) {
    return Expanded(
      child: Stack(
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: size.height * 0.070,
              width: size.width,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
          ),
          if (label != null)
            Positioned(
              top: 6,
              right: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
