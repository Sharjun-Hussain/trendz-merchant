import 'package:flutter/material.dart';

class Quickaction extends StatelessWidget {
  const Quickaction({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.yellow),
            child: Icon(
              Icons.bar_chart,
              size: 50,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Report",
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
