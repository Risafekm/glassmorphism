// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubText extends StatelessWidget {
  String text;
  double size;
  SubText({super.key, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      style: GoogleFonts.lora(
        fontSize: size,
        fontWeight: FontWeight.normal,
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      overflow: TextOverflow.fade,
    );
  }
}
