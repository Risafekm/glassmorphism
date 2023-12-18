// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

ValueNotifier<int> carouselValueNotifier = ValueNotifier(0);

class CarouselWidget extends StatelessWidget {
  CarouselWidget({super.key});

  CarouselController carouselController = CarouselController();

  final CollectionReference carousel =
      FirebaseFirestore.instance.collection('carousel');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: carousel.snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ValueListenableBuilder(
                valueListenable: carouselValueNotifier,
                builder: (context, newIndex, child) {
                  return Stack(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 5, right: 5, left: 5, bottom: 5),

                          ///Carousel Slider adding(sliding album)

                          child: CarouselSlider.builder(
                            carouselController: carouselController,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index, realIndex) {
                              final data = snapshot.data.docs[index];

                              return Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(10, 10),
                                        spreadRadius: 10,
                                        blurRadius: 40),
                                  ],
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        data['image'],
                                      ),
                                      fit: BoxFit.cover,
                                      colorFilter: const ColorFilter.mode(
                                          Colors.white54, BlendMode.softLight)),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              height: 230,
                              autoPlay: true,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                carouselValueNotifier.value = index;
                              },
                            ),
                          )),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: AnimatedSmoothIndicator(
                          activeIndex: newIndex,
                          count: snapshot.data.docs.length,
                          effect: ExpandingDotsEffect(
                            dotColor: Colors.red.shade200,
                            activeDotColor: Colors.red,
                            dotHeight: 7,
                            dotWidth: 6,
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }
          return Container();
        });
  }
}
