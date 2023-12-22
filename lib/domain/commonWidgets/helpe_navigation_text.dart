// ignore_for_file: must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HelperNavigationText extends StatefulWidget {
  VoidCallback onTap;
  String text;
  String help;
  HelperNavigationText(
    this.text,
    this.help, {
    super.key,
    required this.onTap,
  });

  @override
  State<HelperNavigationText> createState() => _HelperNavigationTextState();
}

class _HelperNavigationTextState extends State<HelperNavigationText> {
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: widget.help,
            style: const TextStyle(color: Colors.white),
            children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = widget.onTap,
            text: widget.text,
            style: const TextStyle(
              color: Colors.cyan,
              decoration: TextDecoration.underline,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]));
  }
}
