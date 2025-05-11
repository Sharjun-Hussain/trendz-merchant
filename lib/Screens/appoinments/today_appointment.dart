import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:trendz_merchant/Components/elevated_button.dart';

class TodayAppointment extends StatefulWidget {
  @override
  _TodayBookingPageState createState() => _TodayBookingPageState();
}

class _TodayBookingPageState extends State<TodayAppointment> {
  // final List<Map<String, dynamic>> upcomingBookings = [

  // ];

  String dropdownvalue = 'Maruthamunai';

  final List<Map<String, dynamic>> todayBookings = [
    {
      "reference_no": "REF54321",
      "booking_no": "B004",
      "branch": "Maruthamunai",
      "date_time": "Today | 10:00 AM",
      "qr_code": "REF54321-QR",
      "services": ["Manicure", "Pedicure"],
      "user_name": "Bob Brown",
      "user_profile": "lib/assets/images/user4.png",
    },
    {
      "reference_no": "REF12345",
      "booking_no": "B001",
      "branch": "Maruthamunai",
      "date_time": "Today | 2:00 PM",
      "qr_code": "REF12345-QR",
      "services": ["Haircut", "Shampoo", "Blow-dry"],
      "user_name": "John Doe",
      "user_profile": "lib/assets/images/user1.png",
    },
    {
      "reference_no": "REF67890",
      "booking_no": "B002",
      "branch": "Maruthamunai",
      "date_time": "15/12/2024 | 1:00 PM",
      "qr_code": "REF67890-QR",
      "services": ["Beard Trim", "Facial"],
      "user_name": "Jane Smith",
      "user_profile": "lib/assets/images/user2.png",
    },
    {
      "reference_no": "REF98765",
      "booking_no": "B003",
      "branch": "Sainthamaruthu",
      "date_time": "18/12/2024 | 3:00 PM",
      "qr_code": "REF98765-QR",
      "services": ["Head Massage", "Scalp Treatment"],
      "user_name": "Alice Johnson",
      "user_profile": "lib/assets/images/user3.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Bookings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    DropdownButton(
                      underline: SizedBox.shrink(),
                      value: dropdownvalue,
                      items: ["Maruthamunai", "Sainthamaruthu"]
                          .map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("12")
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: todayBookings.length,
                itemBuilder: (context, index) {
                  final booking = todayBookings[index];
                  // ? todayBookings[index]
                  // : upcomingBookings[index - todayBookings.length];
                  return Card(
                    // color: Theme.of(context).cardColor,
                    color: Colors.grey.withOpacity(0.1),
                    margin: const EdgeInsets.symmetric(vertical: 6.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _showQRCodeDialog(context, booking["qr_code"],
                                booking["reference_no"], booking["booking_no"]);
                          },
                          child: QrImageView(
                            data: booking["qr_code"],
                            backgroundColor: Colors.white,
                            version: QrVersions.auto,
                            size: 60.0,
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            title: InkWell(
                              onTap: () {
                                _showBookingDetailsDialog(context, booking);
                              },
                              child: Text(
                                "Reference Number: ${booking["reference_no"]}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            subtitle: InkWell(
                              onTap: () {
                                _showBookingDetailsDialog(context, booking);
                              },
                              child: Text(
                                "${booking["branch"]}\n${booking["date_time"]}",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBookingDetailsDialog(
      BuildContext context, Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 350, // Set the width of the dialog
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Booking Details",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  CircleAvatar(
                    backgroundImage: AssetImage(booking["user_profile"]),
                    radius: 30,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "User: ${booking["user_name"]}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Reference: ${booking["reference_no"]}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Branch: ${booking["branch"]}\nDate & Time: ${booking["date_time"]}",
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const Divider(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Services:",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 5),
                  ...booking["services"].map<Widget>((service) {
                    return Container(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 18,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(service)
                          ],
                        ));
                  }).toList(),
                  const Divider(height: 20),
                  Column(
                    children: [
                      CustomElevatedButton(
                        text: "Complete Booking",
                        icon: Iconsax.tick_circle,
                        onPressed: () {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Booking completed."),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomElevatedButton(
                        backgroundColor: const Color.fromARGB(255, 255, 17, 0),
                        text: "Cancel Booking",
                        icon: Iconsax.pen_remove,
                        onPressed: () {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Booking cancelled."),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }

  void _showQRCodeDialog(BuildContext context, String qrCodeData,
      String referenceNumber, String bookingNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 350, // Set maximum height
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Booking Details",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Divider(thickness: 1, color: Theme.of(context).dividerColor),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Reference Number:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(referenceNumber),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Booking Number:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(bookingNumber),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: QrImageView(
                      data: qrCodeData,
                      backgroundColor: Colors.white,
                      version: QrVersions.auto,
                      size: 150.0, // Reduced QR code size
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text("Close"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
