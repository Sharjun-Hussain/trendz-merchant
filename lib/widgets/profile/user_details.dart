import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  final String name;
  final String value;

  const UserDetails({super.key, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: 140,
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    "Update User Profile",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              );
            },
          );
        },
        child: Row(
          children: [
            Icon(
              Icons.person_2_outlined,
              size: 40,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: Theme.of(context).textTheme.bodyLarge),
                      Text(value, style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  Icon(Icons.edit),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
