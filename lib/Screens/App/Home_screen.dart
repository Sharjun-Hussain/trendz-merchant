import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trendz_merchant/pages/App/Customers.dart';
import 'package:trendz_merchant/pages/App/appointment.dart';

import 'package:trendz_merchant/pages/App/dashboard.dart';
import 'package:trendz_merchant/pages/App/settings.dart';
import 'package:trendz_merchant/pages/App/offers.dart';
import 'package:trendz_merchant/pages/App/services.dart';
import 'package:trendz_merchant/theming/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex = 0; // Tracks the currently selected page
  final PageController _pageController =
      PageController(); // Controls the PageView

  // Navigate to a page using PageView animation
  void _onNavTap(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
    _pageController.jumpToPage(index); // Jump to the specified page
  }

  // Update the selected index when the page changes
  void _onPageChange(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      Dashboard(),
      const Appointment(),
      const Offers(),
      ServiceManagementPage(),
      // const Customers(),
      // const Settings()
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged:
            _onPageChange, // Syncs the BottomNavigationBar with PageView
        children: _pages,
        physics:
            const NeverScrollableScrollPhysics(), // Disables swipe navigation
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: "Dashboard"),
          BottomNavigationBarItem(
              icon: Icon(Iconsax.book), label: "Appoinments"),
          BottomNavigationBarItem(icon: Icon(Iconsax.flash), label: "Offers"),
          BottomNavigationBarItem(
              icon: Icon(Iconsax.setting), label: "Services"),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.people_alt_outlined), label: "Customers"),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.menu_rounded), label: "More"),
        ],
        currentIndex: _selectedPageIndex, // Highlights the selected tab
        selectedItemColor: AppColors.gold, // Active tab color
        unselectedItemColor: Colors.grey, // Inactive tab color
        showUnselectedLabels: true, // Show labels for inactive tabs
        onTap: (index) {
          _onNavTap(index); // Navigate to the selected page
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose of PageController to free resources
    super.dispose();
  }
}
