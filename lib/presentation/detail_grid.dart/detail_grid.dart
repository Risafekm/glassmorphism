// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/domain/const_values.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/home_Screen/tab_pages/rent.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/home_Screen/tab_pages/sales.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/home_Screen/tab_pages/services.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/home_Screen/tab_pages/sharing.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/home_Screen/widgets/appbar.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/home_Screen/widgets/tab_items.dart';

class DetailsGrid extends StatelessWidget {
  DetailsGrid({super.key, required this.name});

  String name;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final CollectionReference profile =
        FirebaseFirestore.instance.collection('profile');

    return DefaultTabController(
      ///TabBar adding
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 15, 104, 177),
        appBar: appBAR(
            profile,

            //tab Bar area
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
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
                    indicatorPadding: const EdgeInsets.only(
                        left: 11, bottom: 9, top: 7, right: 2),
                    indicator: BoxDecoration(
                        color: const Color.fromARGB(255, 22, 82, 130),
                        borderRadius: BorderRadius.circular(10)),
                    tabs: [
                      Tab(
                        child: TabItems(
                          name: 'Rent',
                        ),
                      ),
                      Tab(
                        child: TabItems(
                          name: 'Sales',
                        ),
                      ),
                      Tab(
                        child: TabItems(
                          name: 'Sharing',
                        ),
                      ),
                      Tab(
                        child: TabItems(
                          name: 'Services',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            name,
            true, ontap: () {
          Navigator.pop(context);
        }),

        /// TabBar viewing area adding

        body: SizedBox(
          height: size.height,
          width: size.width,
          child: const Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    ///Rent  Viewing area adding
                    RentTab(),

                    ///Sales Viewing area adding
                    SalesTab(),

                    ///Sharing  Viewing area adding
                    SharingTab(),

                    ///Services Viewing area adding
                    ServicesTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
