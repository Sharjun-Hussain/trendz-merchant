import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:trendz_merchant/Screens/App/Home_screen.dart';
import 'package:trendz_merchant/Screens/auth/login_screen.dart';
import 'package:trendz_merchant/pages/getting_start.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final LocalAuthentication auth = LocalAuthentication();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final String? firstTime = await secureStorage.read(key: 'first_time');
    final String? token = await secureStorage.read(key: 'token');

    if (firstTime == null) {
      await secureStorage.write(key: 'first_time', value: 'done');
      _navigateTo(const GettingStart());
    } else if (token != null) {
      _navigateTo(const HomeScreen());
    } else {
      _checkLock();
    }
  }

  Future<void> _checkLock() async {
    final String? lockUntil = await secureStorage.read(key: 'lock_until');
    if (lockUntil != null) {
      final DateTime lockTime = DateTime.parse(lockUntil);
      if (DateTime.now().isBefore(lockTime)) {
        _authenticate();
      } else {
        _navigateTo(LoginScreen());
      }
    } else {
      _navigateTo(LoginScreen());
    }
  }

  Future<void> _authenticate() async {
    try {
      final bool authenticated = await auth.authenticate(
        localizedReason: 'Authenticate to unlock TrendZ Merchant App',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (authenticated) {
        await secureStorage.delete(key: 'lock_until');
        _navigateTo(const HomeScreen());
      } else {
        _navigateTo(LoginScreen());
      }
    } catch (e) {
      print('Authentication error: $e');
      _navigateTo(LoginScreen());
    }
  }

  void _navigateTo(Widget screen) {
    setState(() => isLoading = false);
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : const SizedBox.shrink(),
      ),
    );
  }
}
