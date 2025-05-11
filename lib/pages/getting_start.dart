import 'package:flutter/material.dart';
import 'package:trendz_merchant/Components/elevated_button.dart';
import 'package:trendz_merchant/Screens/auth/login_screen.dart';
import 'package:trendz_merchant/pages/onboarding.dart';

class GettingStart extends StatelessWidget {
  const GettingStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Expanded(
                child: Column(
              children: [
                Text(
                  "TrendZ Hair Studio ",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "Merchant App ",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            )),
            Expanded(
              child: Image.asset(
                "lib/assets/images/logo.png",
                width: 250,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomElevatedButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  text: "Get Started",
                  icon: Icons.login,
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomePage()))
                      }),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
