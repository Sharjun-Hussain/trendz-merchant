import 'package:flutter/material.dart';

class CancelledBookingsPage extends StatefulWidget {
  @override
  _CancelledBookingsPageState createState() => _CancelledBookingsPageState();
}

class _CancelledBookingsPageState extends State<CancelledBookingsPage> {
  // Sample data for cancelled bookings
  final List<Map<String, String>> cancelledBookings = [
    {
      "title": "Spa Treatment",
      "details": "Date: 10/12/2024 | Time: 11:00 AM",
      "status": "Cancelled",
      "image": "lib/assets/images/makeover.png"
    },
    {
      "title": "Yoga Class",
      "details": "Date: 13/12/2024 | Time: 8:30 AM",
      "status": "Cancelled",
      "image": "lib/assets/images/makeup.png"
    },
    {
      "title": "Massage Therapy",
      "details": "Date: 17/12/2024 | Time: 5:00 PM",
      "status": "Cancelled",
      "image": "lib/assets/images/massage.png"
    },
  ];

  // Controller for the search field
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredBookings = [];

  @override
  void initState() {
    super.initState();
    _filteredBookings = cancelledBookings;
  }

  void _filterBookings(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredBookings = cancelledBookings;
      } else {
        _filteredBookings = cancelledBookings.where((booking) {
          return booking["title"]!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  Widget _statusIcon(String status) {
    if (status == 'Cancelled') {
      return Icon(Icons.cancel, color: Colors.red, size: 24);
    }
    return SizedBox.shrink(); // No icon for other statuses
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            // Search Field
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: _searchController,
                onChanged: _filterBookings,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search for cancelled bookings...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            // List of Cancelled Bookings
            Expanded(
              child: ListView.builder(
                itemCount: _filteredBookings.length,
                itemBuilder: (context, index) {
                  final booking = _filteredBookings[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          booking["image"]!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        booking["title"]!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        booking["details"]!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: _statusIcon(booking["status"]!),
                      onTap: () {
                        // Implement action when a booking is tapped (e.g., navigate to booking details)
                      },
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
}
