import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trendz_merchant/Components/elevated_button.dart';
import 'package:trendz_merchant/widgets/offers/offer_card.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  String selectedLocation = "Maruthamunai"; // Default branch
  String selectedDate = "Salect Date";

  void offerpopup() {
    showDialog(
        context: context,
        builder: (builder) {
          // return CreateOffer();
          return AlertDialog(
            title: Text("Create Offer"),
            actions: <Widget>[
              ElevatedButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text("Save"),
                onPressed: () {
                  // Save offer details
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Manage Offers",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 17),
        ),
        actions: [
          IconButton(onPressed: () => {}, icon: const Icon(Icons.more_horiz)),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text("Offers", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomElevatedButton(
              text: "Create Offer",
              icon: Iconsax.add,
              onPressed: offerpopup,
            ),
          ),
          const SizedBox(height: 35),
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 15.0,
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       // Location Dropdown
          //       Expanded(
          //         flex: 1,
          //         child: DropdownButtonFormField<String>(
          //           value: selectedLocation,
          //           decoration: InputDecoration(
          //             isDense: true,
          //             labelText: "Location",
          //             labelStyle: Theme.of(context).textTheme.bodyMedium,
          //             border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(8.0),
          //             ),
          //           ),
          //           items: [
          //             "Sainthamaruthu",
          //             "Maruthamunai",
          //           ]
          //               .map((location) => DropdownMenuItem(
          //                     value: location,
          //                     child: Text(
          //                       location,
          //                       style: Theme.of(context).textTheme.bodySmall,
          //                     ),
          //                   ))
          //               .toList(),
          //           onChanged: (value) {
          //             setState(() {
          //               selectedLocation = value!;
          //             });
          //           },
          //         ),
          //       ),
          //       const SizedBox(width: 10),

          //       // Date Picker
          //       Expanded(
          //         flex: 1,
          //         child: GestureDetector(
          //           onTap: () async {
          //             DateTime now = DateTime.now();
          //             DateTime threeDaysLater =
          //                 now.add(const Duration(days: 2));

          //             DateTime? pickedDate = await showDatePicker(
          //               context: context,
          //               initialDate: now,
          //               firstDate: now,
          //               lastDate: threeDaysLater,
          //             );

          //             if (pickedDate != null) {
          //               setState(() {
          //                 selectedDate =
          //                     "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
          //               });
          //             }
          //           },
          //           child: Container(
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 12.0, vertical: 10.0),
          //             decoration: BoxDecoration(
          //               border: Border.all(color: Colors.grey),
          //               borderRadius: BorderRadius.circular(8.0),
          //             ),
          //             child: Text(
          //               selectedDate == null ? "Select Date" : selectedDate,
          //               style: TextStyle(
          //                 color: selectedDate == null
          //                     ? Theme.of(context).primaryColor
          //                     : Theme.of(context).primaryColor,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              "Recent Offers",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: const [
                OfferCard(),

                OfferCard(),
                OfferCard(),
                // Add more OfferCard() widgets as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
