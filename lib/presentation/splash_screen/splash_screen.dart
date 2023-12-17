// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:glassmorphism/domain/commonWidgets/glassmorphism.dart';
import 'package:glassmorphism/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1200), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.teal.shade100,
            Colors.teal.shade100,
            Colors.teal.shade100,
            Colors.teal.shade100,
            Colors.teal.shade100,
          ], begin: Alignment.center, end: Alignment.bottomCenter),
        ),
        child: GlassMorphism(
          blur: 0,
          opacity: .0,
          radius: 0,
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: GlassMorphism(
                  blur: 10,
                  opacity: .4,
                  radius: 40,
                  height: 150,
                  width: 150,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/logo.png'),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'amazon',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
