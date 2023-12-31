// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:glassmorphism/application/provider/provider_bottom.dart';
import 'package:glassmorphism/presentation/bottomnavigation/bottom_widgets/bottom_nav.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/my_ads_screen/my_ads_screen.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/home_Screen/home_screen.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/profile_screen/profile_screen.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/chat_screen/chat_screen.dart';
import 'package:provider/provider.dart';

class MainHome extends StatelessWidget {
  MainHome({super.key});

  List<Widget> pageList = const [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var pageValue = context.watch<ProviderBottomNavigation>();

    return Consumer<ProviderBottomNavigation>(
      builder: (context, pages, child) {
        return Scaffold(
          // backgroundColor: Colors.white,
          bottomNavigationBar: const BottomNavigationBAR(),
          body: pageList[pageValue.pageIndex],
        );
      },
    );
  }
}
