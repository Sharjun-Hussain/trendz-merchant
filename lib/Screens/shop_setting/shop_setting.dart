import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trendz_merchant/Screens/shop_setting/create_timeslot.dart';
import 'package:trendz_merchant/widgets/Navigation.dart';
import 'package:trendz_merchant/widgets/main_navigation.dart';

class ShopSettingsPage extends StatefulWidget {
  const ShopSettingsPage({super.key});

  @override
  State<ShopSettingsPage> createState() => _ShopSettingsPageState();
}

class _ShopSettingsPageState extends State<ShopSettingsPage> {
  // Sample data for shop settings
  String shopName = 'My Shop';
  String shopDescription = 'Best products for your needs';
  String shopCurrency = 'USD';
  String shopEmail = 'shop@example.com';
  String shopPhone = '+1234567890';
  String shopAddress = '123 Main St, City, Country';
  bool isShopOpen = true;

  // Sample payment methods
  List<String> paymentMethods = ['PayPal', 'Stripe', 'Credit Card'];
  String selectedPaymentMethod = 'PayPal';

  // Sample shipping methods
  List<String> shippingMethods = ['Standard Shipping', 'Express Shipping'];
  String selectedShippingMethod = 'Standard Shipping';

  // Sample product categories
  List<String> productCategories = ['Electronics', 'Clothing', 'Home Goods'];
  String selectedCategory = 'Electronics';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shop Settings',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // General Settings Section
            Text(
              "General Settings",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isShopOpen =
                            !isShopOpen; // Toggle the shop open/close state
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: 100,
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: isShopOpen ? Colors.red : Colors.green,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 5,
                            spreadRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          isShopOpen
                              ? "Close Branch"
                              : "Open Branch", // Conditional text
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.amber[100],
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        "Manage Time Slots",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // Save Button
            ElevatedButton(
              onPressed: () {
                // Here you can implement the logic to save settings to the server or database
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Settings saved successfully')));
              },
              child: Text(
                'Save Settings',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
