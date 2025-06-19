import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seclobtechnologies_task/home_screen/controller/bottomNav_controller.dart';
import 'package:seclobtechnologies_task/home_screen/view/homescreen.dart';
import 'package:seclobtechnologies_task/profile_screen/view/profile_screen.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});

  final List<Widget> _screens = [
    HomeScreen(),
    const Center(child: Text("Revenue")),
    const Center(child: Text("History")),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavObj = Provider.of<BottomNavController>(context);

    return Scaffold(
      body: _screens[bottomNavObj.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomNavObj.currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: (index) => bottomNavObj.changeIndex(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_rupee),
            label: "Revenue",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Profile"),
        ],
      ),
    );
  }
}
