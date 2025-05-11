import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trendz_merchant/Components/elevated_button.dart';
import 'package:trendz_merchant/Screens/qr/scanner.dart';
import 'package:trendz_merchant/pages/App/settings.dart';
import 'package:trendz_merchant/widgets/DashboardCard.dart';
import 'package:trendz_merchant/widgets/form_input.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final securestorage = FlutterSecureStorage();

  String? name;
  String? branch;
  String? saloonName;

  Future<void> _fetchUserDetails() async {
    name = await securestorage.read(key: "fullname");
    branch = await securestorage.read(key: "branch");
    saloonName = await securestorage.read(key: "saloon_name");
    setState(() {}); // Update UI after fetching details
  }

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Dashboard"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const Settings()),
            ),
            child: const CircleAvatar(
              backgroundImage: AssetImage("lib/assets/images/logo.png"),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Text(
                    "Hi ${name ?? 'Merchant'}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: FormInput(
                inputName: "Search by ref",
                placeHolder: "TRZ110023",
                inputController: searchController,
                inputType: "text",
                autofocus: false,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QRScannerScreen()),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: double.infinity,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Scan QR Code:",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Icon(
                            Icons.qr_code_scanner,
                            size: 80,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Upcoming Bookings",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text("12.00 - 14.00",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold)),
                      Text("Pending : 4 ",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: Colors.green[400],
                                  fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).focusColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Reference No : SLDD234r2r"),
                              Text("Booking Number  : SLDD234r2r"),
                              Text("Mohamed Anver"),
                            ],
                          ),
                          CircleAvatar(
                            radius: 30,
                          )
                        ],
                      )),
                  const SizedBox(height: 15),
                  CustomElevatedButton(
                      text: "See all appointments",
                      icon: Iconsax.arrow_right,
                      onPressed: () {}),
                  const SizedBox(height: 20),
                  Text(
                    "Summary",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Dashboardcard(
                        title: "Today Appointments",
                        imageurl: "lib/assets/images/chart1.png",
                        value: 12,
                      ),
                      SizedBox(width: 10),
                      Dashboardcard(
                        title: "Tomorrow Appointments",
                        imageurl: "lib/assets/images/chart2.png",
                        value: 12,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Dashboardcard(
                        title: "Today Revenue",
                        imageurl: "lib/assets/images/chart4.png",
                        value: 5500,
                      ),
                      SizedBox(width: 10),
                      Dashboardcard(
                        title: "Revenue this month",
                        imageurl: "lib/assets/images/chart5.png",
                        value: 120000,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withOpacity(0.1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "lib/assets/images/logo.png",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            saloonName ?? "TrendZ Hair Studio",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Merchant Platform",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.science_outlined,
                      color: Theme.of(context).primaryColor,
                      size: 32,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
