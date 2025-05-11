import 'package:flutter/material.dart';

class Dashboardcard extends StatelessWidget {
  final String title;
  final int value;
  final String imageurl;
  const Dashboardcard(
      {super.key,
      required this.title,
      required this.imageurl,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          height: 100,
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              // color: Theme.of(context).cardColor,
              color: Colors.grey.withOpacity(0.1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$value",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Image.asset(
                    "$imageurl",
                    width: 50,
                  ),
                ],
              ),
              Text(
                "$title",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 3,
              )
            ],
          )),
    );
  }
}
