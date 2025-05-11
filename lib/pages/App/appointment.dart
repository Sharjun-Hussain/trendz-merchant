import 'package:flutter/material.dart';
import 'package:trendz_merchant/Screens/appoinments/future_appointment.dart';
import 'package:trendz_merchant/Screens/appoinments/today_appointment.dart';
import 'package:trendz_merchant/Screens/appoinments/tomorrow_appointment.dart';

class Appointment extends StatelessWidget {
  const Appointment({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Appointments",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            labelStyle: Theme.of(context).textTheme.bodySmall,
            tabs: const [
              Tab(
                text: "Today",
              ),
              Tab(
                text: "Tomorrow",
              ),
              Tab(
                text: "Future",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TodayAppointment(),
            TomorrowAppointment(),
            FutureAppointment()
          ],
        ),
      ),
    );
  }
}
