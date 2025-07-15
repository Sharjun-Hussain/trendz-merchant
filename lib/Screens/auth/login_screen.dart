import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:trendz_merchant/Components/elevated_button.dart';
import 'package:trendz_merchant/Models/usermodel.dart';
import 'package:trendz_merchant/Providers/user_provider.dart';
import 'package:trendz_merchant/Screens/App/Home_screen.dart';
import 'package:trendz_merchant/Screens/auth/forgot_password.dart';
import 'package:trendz_merchant/Services/auth_services.dart';
import 'package:trendz_merchant/widgets/form_input.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  final securestorage = FlutterSecureStorage();

  void handleLogin(BuildContext context,
      Future<Map<String, dynamic>> Function() loginMethod) async {
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => const HomeScreen()),
    //   (Route<dynamic> route) => false,
    // );
    try {
      final response = await loginMethod();
      // final user = User.fromJson(response);
      // print(user.toJson());

      // await securestorage.write(key: "token", value: user.token);
      // await securestorage.write(key: "userid", value: user.id.toString());
      // await securestorage.write(key: "fullname", value: user.name);
      // await securestorage.write(key: "email", value: user.email);
      // await securestorage.write(key: "status", value: user.status.toString());
      // await securestorage.write(
      //     key: "saloon_id", value: user.saloon_id.toString());
      // await securestorage.write(key: "image", value: user.image);
      // await securestorage.write(key: "saloon_name", value: user.saloon_name);
      // await securestorage.write(key: "branch", value: user.branch);

      // Provider.of<UserProvider>(context, listen: false).setUser(user);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  State<LoginScreen> createState() => _OnboardingState();
}

class _OnboardingState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  bool isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    emailcontroller.addListener(_checkFormValidity);
    passwordcontroller.addListener(_checkFormValidity);
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  void _checkFormValidity() {
    final isFormValid =
        emailcontroller.text.isNotEmpty && passwordcontroller.text.isNotEmpty;
    if (isButtonDisabled != !isFormValid) {
      setState(() {
        isButtonDisabled = !isFormValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // This ensures that the form is scrollable
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
              clipper: BottomRoundedClipper(),
              child: Container(
                height: 150,
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      "Welcome To Trendz",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Signin to continue",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 35),
                    FormInput(
                      inputType: "email",
                      inputController: emailcontroller,
                      inputName: "Email",
                      placeHolder: "Enter Email",
                    ),
                    const SizedBox(height: 25),
                    FormInput(
                      obscureText: true,
                      inputType: "password",
                      inputController: passwordcontroller,
                      inputName: "Password",
                      placeHolder: "Enter Password",
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()))
                          },
                          child: Text(
                            "Forgot Password?",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 25),
                    CustomElevatedButton(
                      icon: Iconsax.login,
                      text: "Login",
                      onPressed: isButtonDisabled
                          ? null // Disable button when form is invalid
                          : () => widget.handleLogin(
                                context,
                                () => AuthService().loginWithEmailPassword(
                                  emailcontroller.text,
                                  passwordcontroller.text,
                                ),
                              ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomRoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 45); // Bottom-left edge
    path.quadraticBezierTo(
      size.width / 2, // Control point (x)
      size.height + 45, // Control point (y)
      size.width, // End point (x)
      size.height - 45, // End point (y)
    );
    path.lineTo(size.width, 0); // Top-right edge
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
