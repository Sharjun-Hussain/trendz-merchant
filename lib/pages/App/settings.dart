import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:trendz_merchant/Components/elevated_button.dart';
import 'package:trendz_merchant/Providers/user_provider.dart';
import 'package:trendz_merchant/Screens/Profile/Profile_page.dart';
import 'package:trendz_merchant/Screens/Reports/report.dart';
import 'package:trendz_merchant/Screens/auth/login_screen.dart';
import 'package:trendz_merchant/Screens/shop_setting/shop_setting.dart';
import 'package:trendz_merchant/pages/splashScreen.dart';
import 'package:trendz_merchant/widgets/Navigation.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Settings> {
  final secureStorage = const FlutterSecureStorage();
  String? _fullName;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Read the full name from SecureStorage
    String? fullName = await secureStorage.read(key: "fullname");
    String? email = await secureStorage.read(key: "email");
    setState(() {
      _fullName = fullName;
      _email = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage("lib/assets/images/profile.png"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$_fullName",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 20),
                          ),
                          Text(
                            "$_email",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomNavigation(
                  navigate: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const ProfilePage()));
                    // Navigate to a specific profile detail page
                  },
                  navigationtitle: "Profile Settings",
                  navigationIcon: Icon(
                    Iconsax.personalcard,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                CustomNavigation(
                  navigate: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const ShopSettingsPage()));
                    // Navigate to a settings page
                  },
                  navigationtitle: "Shop Settings",
                  navigationIcon: Icon(
                    Iconsax.setting,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                CustomNavigation(
                  navigate: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SalesReportPage()));
                    // Navigate to a settings page
                  },
                  navigationtitle: "Reports",
                  navigationIcon: Icon(
                    Iconsax.setting,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                CustomNavigation(
                  navigate: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()));
                    // Navigate to a settings page
                  },
                  navigationtitle: "Customers Feedbacks",
                  navigationIcon: Icon(
                    Iconsax.voice_cricle,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                CustomNavigation(
                  navigate: () {
                    // Navigate to a privacy policy page
                  },
                  navigationtitle: "Privacy Policy",
                  navigationIcon: Icon(
                    Iconsax.setting_4,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                CustomNavigation(
                  navigate: () {
                    // Navigate to a privacy policy page
                  },
                  navigationtitle: "App Updates",
                  navigationIcon: Icon(
                    Iconsax.cpu,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "App Version: 1.0.0",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(height: 10),
                CustomElevatedButton(
                  text: "Logout",
                  icon: Iconsax.logout4,
                  onPressed: () {
                    _showConfirmationDialog(context);
                    // await secureStorage.write(key: "token", value: "");
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => Onboarding(),
                    //   ),
                    //   (route) => false,
                    // );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await secureStorage.delete(
                  key: "token",
                );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SplashScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Text(
                'Yes',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        );
      },
    );
  }
}
