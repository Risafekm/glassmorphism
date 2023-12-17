// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BottomNavignItems extends StatelessWidget {
  void Function() ontap;
  IconData icon;
  String text;
  Color color;
  double size;

  BottomNavignItems({
    super.key,
    required this.ontap,
    required this.icon,
    required this.text,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(4),
        height: 70,
        child: Column(
          children: [
            Icon(
              icon,
              size: size,
              color: color,
            ),
            const SizedBox(height: 2),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 10, color: color, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
