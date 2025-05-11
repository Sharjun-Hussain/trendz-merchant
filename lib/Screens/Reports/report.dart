import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SalesReportPage extends StatefulWidget {
  const SalesReportPage({super.key});

  @override
  State<SalesReportPage> createState() => _SalesReportPageState();
}

class _SalesReportPageState extends State<SalesReportPage> {
  String dropdownvalue = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Sales Report",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 17),
      )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Range Selector and Export Buttons
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Filter by Date',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Download PDF',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Download CSV',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Sales Overview Section (Just for context, remove if not needed)
              const Text(
                "Sales Overview",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Card(
                color: Colors.grey.withOpacity(0.1),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total Sales", style: TextStyle(fontSize: 16)),
                          SizedBox(height: 5),
                          Text("Rs.140,000",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total Appointments",
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 5),
                          Text("350",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Appointments Trend (Line Chart)
              const Text(
                "Appointments",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.black, width: 1)),
                    lineBarsData: [
                      LineChartBarData(
                        spots: _getSalesTrendData(),
                        isCurved: true,
                        color: Colors.blue,
                        belowBarData: BarAreaData(
                            show: true, color: Colors.blue.withOpacity(0.3)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Revenue Bar Chart Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Revenue",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton(
                    underline: const SizedBox.shrink(),
                    value: dropdownvalue,
                    items: ["Today", "This month", "This year", "All"]
                        .map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
                child: BarChart(
                  BarChartData(
                    gridData: const FlGridData(show: true),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: true),
                    barGroups: _getRevenueData(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Sample data for the appointments trend (Line Chart)
  List<FlSpot> _getSalesTrendData() {
    return [
      const FlSpot(0, 1000), // Day 0: 1000 appointments
      const FlSpot(1, 1200), // Day 1: 1200 appointments
      const FlSpot(2, 1500), // Day 2: 1500 appointments
      const FlSpot(3, 1300), // Day 3: 1300 appointments
      const FlSpot(4, 1700), // Day 4: 1700 appointments
    ];
  }

  // Sample data for revenue (Bar Chart)
  List<BarChartGroupData> _getRevenueData() {
    return [
      BarChartGroupData(x: 0, barRods: [
        BarChartRodData(toY: 5000, color: Colors.green, width: 15),
      ]), // Day 0: Rs 5000 revenue
      BarChartGroupData(x: 1, barRods: [
        BarChartRodData(toY: 3000, color: Colors.green, width: 15),
      ]), // Day 1: Rs 3000 revenue
      BarChartGroupData(x: 2, barRods: [
        BarChartRodData(toY: 2000, color: Colors.green, width: 15),
      ]), // Day 2: Rs 2000 revenue
      BarChartGroupData(x: 3, barRods: [
        BarChartRodData(toY: 4000, color: Colors.green, width: 15),
      ]), // Day 3: Rs 4000 revenue
      BarChartGroupData(x: 4, barRods: [
        BarChartRodData(toY: 6000, color: Colors.green, width: 15),
      ]), // Day 4: Rs 6000 revenue
    ];
  }
}
