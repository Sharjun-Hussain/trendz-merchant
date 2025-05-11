import 'package:flutter/material.dart';
import 'package:trendz_merchant/widgets/profile/user_details.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                child: IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: const Icon(Icons.arrow_back_ios_new)),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 85,
                    child: Image.asset(
                      "lib/assets/images/logo.png",
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Sharjun Hussain",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Short Text Description ",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  UserDetails(
                    name: "Name",
                    value: "Sharjun Hussain",
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  UserDetails(
                    name: "Phone",
                    value: "+9475 73 33 221",
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  UserDetails(
                    name: "Email",
                    value: "SharjunHussain@outlook.com",
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
