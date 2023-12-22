import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:glassmorphism/animation/ui/delayed_animation.dart';
import 'package:google_fonts/google_fonts.dart';

class SharingTab extends StatelessWidget {
  const SharingTab({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference sharing =
        FirebaseFirestore.instance.collection('sharing');
    return StreamBuilder(
        stream: sharing.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.amber));
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error Loaded'));
          } else if (snapshot.hasData) {
            return subSharingGrid(snapshot);
          }
          return Container();
        });
  }

  Widget subSharingGrid(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return GridView.builder(
      itemCount: snapshot.data?.docs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final data = snapshot.data!.docs[index];

        return Stack(
          children: [
            InkWell(
                onTap: () {},
                child: GlassContainer.clearGlass(height: 200, width: 200)),
            Positioned(
              bottom: 10,
              child: DelayedAnimation(
                delayedAnimation: 3,
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
                delayedAnimation: 3,
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
        );
      },
    );
  }
}
