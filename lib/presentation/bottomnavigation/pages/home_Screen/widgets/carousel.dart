// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

ValueNotifier<int> carouselValueNotifier = ValueNotifier(0);

class CarouselWidget extends StatelessWidget {
  CarouselWidget({super.key});

  CarouselController carouselController = CarouselController();

  List listImage = [
    'https://assetsio.reedpopcdn.com/AvatarWay.jpg?width=1600&height=900&fit=crop&quality=100&format=png&enable=upscale&auto=webp',
    'https://p6.focus.de/img/fotos/id_180455356/avatar-2-kritik.jpg?im=Resize%3D%28800%2C450%29&impolicy=perceptual&quality=mediumHigh&hash=6d2019930580fa2eaafcba170f286475b5cde89e424a16beae67c7f4732d67be',
    'https://lumiere-a.akamaihd.net/v1/images/au_hero_20cs_avatarwayofwater_newart2_v5_d_19ea3cba.jpeg?region=0,0,2048,878',
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: carouselValueNotifier,
        builder: (context, newIndex, child) {
          return Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 15),

                  ///Carousel Slider adding(sliding album)

                  child: CarouselSlider.builder(
                    carouselController: carouselController,
                    itemCount: listImage.length,
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
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
                                listImage[index],
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
              const Positioned(
                left: 10,
                bottom: 30,
                child: Text('Avatar:The Way of Water',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: AnimatedSmoothIndicator(
                  activeIndex: newIndex,
                  count: listImage.length,
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
}
