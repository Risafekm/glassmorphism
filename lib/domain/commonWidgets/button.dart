// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:glassmorphism/domain/commonWidgets/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  String text;
  VoidCallback ontap;
  CustomButton({
    super.key,
    required this.text,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      blur: 0.2,
      opacity: .3,
      radius: 10,
      height: 50,
      width: 250,
      child: ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
          elevation: 10,
          side: const BorderSide(
            width: 2,
            color: Color.fromARGB(31, 80, 64, 198),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.crimsonText(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
