import 'package:flutter/material.dart';

class MainNavigationForUserProfilePage extends StatelessWidget {
  final String navigationtitle;
  final Widget navigationIcon; // Keep it as a Widget to allow flexibility
  final VoidCallback navigate;

  const MainNavigationForUserProfilePage(
      {super.key,
      required this.navigationtitle,
      required this.navigationIcon,
      required this.navigate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigate,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        height: 60,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      navigationIcon,
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        navigationtitle,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 24,
                      weight: 3,
                      color: Theme.of(context).primaryColor,
                    ), // Use the widget directly here
                    SizedBox(
                      width: 6,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
