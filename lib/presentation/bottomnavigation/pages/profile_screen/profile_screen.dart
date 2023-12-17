import 'package:flutter/material.dart';
import 'package:glassmorphism/application/services/api.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          onPressed: () {
            Api.signOut();
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
