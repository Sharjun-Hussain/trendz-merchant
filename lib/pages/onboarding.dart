import 'package:flutter/material.dart';
import 'package:trendz_merchant/Screens/auth/login_screen.dart';
import 'package:onboarding/onboarding.dart';
import 'package:trendz_merchant/Screens/onboarding/onboardingpage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Onboarding(
        swipeableBody: [
          OnboardingPage(
            title: 'Welcome',
            description:
                "Welcome to Trendz Merchant, your salon's growth partner!.",
            image: Icons.looks_one,
          ),
          OnboardingPage(
            title: 'Explore Features',
            description:
                'Manage bookings, track sales, and grow your business effortlessly.',
            image: Icons.explore,
          ),
          OnboardingPage(
            title: 'Get Started',
            description: 'Ready to elevate your salon experience?',
            image: Icons.start,
          ),
        ],
        startIndex: 0,
        animationInMilliseconds: 500,
        onPageChanges:
            (netDragDistance, pagesLength, currentIndex, slideDirection) {
          print('Page Changed: $currentIndex');
        },
        buildFooter: (context, netDragDistance, pagesLength, currentIndex,
            setIndex, slideDirection) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(pagesLength, (index) {
                    return GestureDetector(
                      onTap: () => setIndex(index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: currentIndex == index ? 16 : 12,
                        height: currentIndex == index ? 16 : 12,
                        decoration: BoxDecoration(
                          color:
                              currentIndex == index ? Colors.blue : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (currentIndex == pagesLength - 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      } else {
                        setIndex(pagesLength - 1);
                      }
                    },
                    child: Text(
                      currentIndex == pagesLength - 1 ? 'Login' : 'Skip',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
