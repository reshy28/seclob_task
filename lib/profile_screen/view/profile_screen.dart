import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:seclobtechnologies_task/login_screen/controller/login_controller.dart';
import 'package:seclobtechnologies_task/profile_screen/controller/profilescreen_controller.dart';
import 'package:seclobtechnologies_task/constants/colors.dart';
import 'package:seclobtechnologies_task/constants/images.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profilescrenObj = Provider.of<ProfilescreenController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: Icon(Icons.arrow_back, color: Colors.white),

        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: profilescrenObj.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : profilescrenObj.profileDatas.isEmpty
                  ? const Text(
                      "No user data available",
                      style: TextStyle(color: Colors.white),
                    )
                  : Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(AppImages.avatarImage),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profilescrenObj.profileDatas.first.name,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              profilescrenObj.profileDatas.first.email,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ),

          // Settings Section
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                const Text(
                  "Account",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),

                const SizedBox(height: 20),
                customProfileItem(
                  title: "Profile",
                  icon: IconlyLight.profile,
                  onTap: () {},
                ),
                customSwitchItem(
                  title: "Darkmode",
                  icon: Icons.brightness_2_outlined,
                ),
                customSwitchItem(
                  title: "Notification",
                  icon: IconlyLight.notification,
                ),
                customProfileItem(
                  title: "Bank Account",
                  icon: Icons.account_balance_outlined,
                  onTap: () {},
                ),
                customProfileItem(
                  title: "Help & Support",
                  icon: Icons.headset_mic_outlined,
                  onTap: () {},
                ),
                customProfileItem(
                  title: "Consumer policies",
                  icon: Icons.assignment_turned_in_outlined,
                  onTap: () {},
                ),
                customProfileItem(
                  title: "Log out",
                  textColor: Colors.red,
                  icon: Icons.logout_outlined,
                  iconColor: Colors.red,
                  showTrailing: false,
                  onTap: showLogoutDialog,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customProfileItem({
    required String title,
    required IconData icon,
    VoidCallback? onTap,
    Color? iconColor,
    Color? textColor,
    bool showTrailing = true,
    bool isSwitch = false,
    bool switchValue = false,
    ValueChanged<bool>? onSwitchChanged,
  }) {
    if (isSwitch) {
      return SwitchListTile(
        contentPadding: EdgeInsets.zero,
        value: switchValue,
        onChanged: onSwitchChanged,
        title: Text(title, style: TextStyle(color: textColor)),
        secondary: Icon(icon, color: iconColor),
      );
    } else {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: onTap,
        leading: Icon(icon, color: iconColor),
        title: Text(title, style: TextStyle(color: textColor)),
        trailing: showTrailing
            ? const Icon(Icons.arrow_forward_ios, size: 16)
            : null,
      );
    }
  }

  void showLogoutDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                child: Icon(IconlyLight.info_circle, color: Colors.red),
              ),
              SizedBox(height: 10),
              const Text(
                "log out?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Are you sure you want to log out?",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: customButton(
                      onPressed: () => Navigator.pop(context),
                      text: "CANCEL",
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      borderColor: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: customButton(
                      onPressed: () {
                        final loginObj = Provider.of<LoginController>(
                          context,
                          listen: false,
                        );
                        loginObj.logout(context);
                      },
                      text: "Log Out",
                      backgroundColor: Colors.red,
                      borderColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget customButton({
    required String text,
    required VoidCallback onPressed,
    Color backgroundColor = Colors.blue,
    Color textColor = Colors.white,
    Color borderColor = Colors.blue,
    double? width,
    double? height,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height ?? 40,
        width: width ?? 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: backgroundColor,
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: Text(text, style: TextStyle(color: textColor)),
        ),
      ),
    );
  }

  Widget customSwitchItem({required String title, required IconData icon}) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      value: false,

      onChanged: (value) {},
      title: Text(title),
      secondary: Icon(icon),
    );
  }
}
