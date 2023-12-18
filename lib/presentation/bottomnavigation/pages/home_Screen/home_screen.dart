// ignore_for_file: unused_local_variable, file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:glassmorphism/domain/const_values.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/home_Screen/tab_pages/mens_tab.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/home_Screen/tab_pages/womens_tab.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/home_Screen/widgets/tab_items.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      ///TabBar adding
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor:
            const Color.fromARGB(255, 124, 181, 228).withOpacity(1),
        appBar: AppBar(
          backgroundColor: Colors.blue.shade200,
          toolbarHeight: 250,
          title: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Estore',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  GlassContainer.clearGlass(
                    height: 150,
                    blur: 2,
                    borderWidth: 2,
                    width: double.maxFinite,
                    gradient: LinearGradient(colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.5),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    // child: CarouselWidget(),
                  ),
                ],
              ),
              Positioned(
                top: -10,
                right: 50,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
              ),
              Positioned(
                top: -10,
                right: 0,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person),
                ),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Stack(
              children: [
                TabBar(
                    overlayColor:
                        const MaterialStatePropertyAll(Colors.transparent),
                    dividerHeight: 0,
                    isScrollable: true,
                    labelColor: kselectedTabColor,
                    unselectedLabelColor: kunselectedTabColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: ktransperant,
                    tabAlignment: TabAlignment.start,
                    labelPadding: const EdgeInsets.only(left: 5),
                    indicatorPadding:
                        const EdgeInsets.only(left: 20, bottom: 10, top: 10),
                    indicator: BoxDecoration(
                        color: const Color.fromARGB(255, 19, 95, 22),
                        // border: Border.all(color: Colors.blue.shade100),
                        borderRadius: BorderRadius.circular(30)),
                    tabs: [
                      Tab(
                        child: TabItems(
                          name: 'Mens',
                        ),
                      ),
                      Tab(
                        child: TabItems(
                          name: 'Womens',
                        ),
                      ),
                      Tab(
                        child: TabItems(
                          name: 'Childrens',
                        ),
                      ),
                      Tab(
                        child: TabItems(
                          name: 'Smart phones',
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

            Text('3rd'),
            Text('4th'),
          ],
        ),
      ),
    );
  }
}
