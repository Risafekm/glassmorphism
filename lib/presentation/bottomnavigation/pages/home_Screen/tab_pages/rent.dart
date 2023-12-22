// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:glassmorphism/animation/ui/delayed_animation.dart';
import 'package:glassmorphism/presentation/details_screen/details_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class RentTab extends StatelessWidget {
  const RentTab({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference rent =
        FirebaseFirestore.instance.collection('rent');
    return StreamBuilder(
        stream: rent.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.amber));
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error Loaded'));
          } else if (snapshot.hasData) {
            return subRentGrid(snapshot);
          }
          return Container();
        });
  }

  Widget subRentGrid(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return GridView.builder(
      itemCount: snapshot.data?.docs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final data = snapshot.data!.docs[index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(
                  title: data['name'],
                  image: data['image'],
                  description: data['description'],
                ),
              ),
            );
          },
          child: Stack(
            children: [
              GlassContainer.clearGlass(height: 200, width: 200),
              Positioned(
                bottom: 10,
                child: DelayedAnimation(
                  delayedAnimation: 2,
                  aniOffsetX: 0,
                  aniOffsetY: .12,
                  aniDuration: 800,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: Text(
                      data['name'],
                      style: GoogleFonts.notoSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 20,
                child: DelayedAnimation(
                  delayedAnimation: 2,
                  aniOffsetX: 0,
                  aniOffsetY: .12,
                  aniDuration: 800,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(data['image']),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
