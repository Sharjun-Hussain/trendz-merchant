import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendz_merchant/Providers/theme_provider.dart';
import 'package:trendz_merchant/Providers/user_provider.dart';
import 'package:trendz_merchant/pages/splashScreen.dart';
import 'package:trendz_merchant/theming/dark_theme.dart';
import 'package:trendz_merchant/theming/light_theme.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
    child: const AuthWrapper(),
  ));
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      home: SplashScreen(),
    );
  }
}
