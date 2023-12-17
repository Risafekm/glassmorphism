// ignore_for_file: unused_local_variable, file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:glassmorphism/domain/const_values.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/home_Screen/tab_pages/mens_tab.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/home_Screen/tab_pages/womens_tab.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/home_Screen/widgets/carousel.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/home_Screen/widgets/tab_items.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      ///TabBar adding
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor:
            const Color.fromARGB(255, 124, 181, 228).withOpacity(1),
        appBar: AppBar(
          backgroundColor:
              const Color.fromARGB(255, 124, 181, 228).withOpacity(1),
          toolbarHeight: 250,
          title: GlassContainer.clearGlass(
            height: 150,
            width: size.width,
            child: CarouselWidget(),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Stack(
              children: [
                TabBar(
                    dividerHeight: 0,
                    isScrollable: true,
                    labelColor: kselectedTabColor,
                    unselectedLabelColor: kunselectedTabColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: ktransperant,
                    tabAlignment: TabAlignment.start,
                    labelPadding: const EdgeInsets.only(left: 10),
                    indicatorPadding:
                        const EdgeInsets.only(left: 20, bottom: 10, top: 10),
                    indicator: tabDecoration,
                    tabs: [
                      Tab(
                        child: TabItems(
                          name: 'Movies',
                        ),
                      ),
                      Tab(
                        child: TabItems(
                          name: 'Tv Shows',
                        ),
                      ),
                    ]),
              ],
            ),
          ),
        ),

        /// TabBar viewing area adding

        body: const TabBarView(
          children: [
            ///Mens Items Viewing area adding

            MensTab(),

            ///Women items Viewing area adding

            WomensTab(),
          ],
        ),
      ),
    );
  }
}
