import 'package:flutter/material.dart';

class UpcomingBookingsPage extends StatefulWidget {
  @override
  _UpcomingBookingsPageState createState() => _UpcomingBookingsPageState();
}

class _UpcomingBookingsPageState extends State<UpcomingBookingsPage> {
  // Sample data for upcoming bookings
  final List<Map<String, String>> upcomingBookings = [
    {
      "title": "Haircut",
      "details": "Date: 12/12/2024 | Time: 2:00 PM",
      "status": "Upcoming",
      "image": "lib/assets/images/haircut.png"
    },
    {
      "title": "Beard Trim",
      "details": "Date: 15/12/2024 | Time: 1:00 PM",
      "status": "Upcoming",
      "image": "lib/assets/images/makeup.png"
    },
    {
      "title": "Head Massage",
      "details": "Date: 18/12/2024 | Time: 3:00 PM",
      "status": "Upcoming",
      "image": "lib/assets/images/makeover.png"
    },
  ];

  // Controller for the search field
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredBookings = [];

  @override
  void initState() {
    super.initState();
    _filteredBookings = upcomingBookings;
  }

  void _filterBookings(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredBookings = upcomingBookings;
      } else {
        _filteredBookings = upcomingBookings.where((booking) {
          return booking["title"]!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
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
                  hintText: 'Search for bookings...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            // List of Bookings
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
                      trailing: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          booking["status"]!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
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
