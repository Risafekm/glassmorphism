import 'package:flutter/material.dart';
import 'package:glassmorphism/application/services/api.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Api.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
