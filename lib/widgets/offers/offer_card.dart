import 'package:flutter/material.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 120,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        )
      ]),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(left: 10),
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(8)),
              child: Image.asset(
                "lib/assets/images/haircut.png",
                fit: BoxFit.contain,
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Christmas Offer",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    "Christmas Offer Description",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "Price : 450",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "Discount : 20%",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
