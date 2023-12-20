// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:glassmorphism/application/provider/provider_bottom.dart';
import 'package:glassmorphism/presentation/bottomnavigation/bottom_widgets/bottom_navigationitems.dart';
import 'package:provider/provider.dart';

class BottomNavigationBAR extends StatelessWidget {
  const BottomNavigationBAR({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var pageValue = context.watch<ProviderBottomNavigation>();

    return Consumer<ProviderBottomNavigation>(
      builder: (BuildContext context, pages, Widget? child) {
        return SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width * 9,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.lightBlue.shade400,
                Colors.lightBlue.shade600,
              ], begin: Alignment.centerLeft, end: Alignment.centerRight),
            ),
            child: GlassContainer.clearGlass(
              height: 70,
              width: MediaQuery.of(context).size.width * 9,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.symmetric(vertical: 10),
              borderRadius: BorderRadius.circular(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomNavignItems(
                    ontap: () {
                      pages.pageChange = 0;
                    },
                    icon:
                        pages.pageIndex == 0 ? Icons.home : Icons.home_outlined,
                    size: pages.pageIndex == 0 ? 26 : 22,
                    color: pages.pageIndex == 0 ? Colors.black : Colors.white,
                    text: 'Home',
                  ),
                  BottomNavignItems(
                    ontap: () {
                      pages.pageChange = 1;
                    },
                    icon:
                        pages.pageIndex == 1 ? Icons.chat : Icons.chat_outlined,
                    size: pages.pageIndex == 1 ? 26 : 22,
                    color: pages.pageIndex == 1 ? Colors.black : Colors.white,
                    text: 'Chat',
                  ),
                  BottomNavignItems(
                    ontap: () {
                      pages.pageChange = 2;
                    },
                    icon: pages.pageIndex == 2
                        ? Icons.ads_click
                        : Icons.ads_click_outlined,
                    size: pages.pageIndex == 2 ? 26 : 22,
                    color: pages.pageIndex == 2 ? Colors.black : Colors.white,
                    text: 'My Ads',
                  ),
                  BottomNavignItems(
                    ontap: () {
                      pages.pageChange = 3;
                    },
                    icon: pages.pageIndex == 3
                        ? Icons.person
                        : Icons.person_2_outlined,
                    size: pages.pageIndex == 3 ? 26 : 22,
                    color: pages.pageIndex == 3 ? Colors.black : Colors.white,
                    text: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Container(
//             height: 70,
//             padding:
//                 const EdgeInsets.only(left: 0, right: 0, top: 12, bottom: 10),
//             margin: const EdgeInsets.symmetric(horizontal: 5),
//             decoration: BoxDecoration(
//               color: Colors.black,
//               // color: Color.fromARGB(170, 101, 88, 184),
//               borderRadius: BorderRadius.circular(16),
//             ),
