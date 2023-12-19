// ignore_for_file: unused_local_variable, file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:glassmorphism/presentation/sub_grid.dart/sub_grid.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final CollectionReference categories =
        FirebaseFirestore.instance.collection('categories');

    final CollectionReference profile =
        FirebaseFirestore.instance.collection('profile');

    ///TabBar adding
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 15, 104, 177),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor:
              const Color.fromARGB(255, 59, 151, 227).withOpacity(.6),
          title: Row(
            children: [
              const Icon(
                Icons.dashboard,
                color: Colors.white,
                size: 26,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Hi',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
              const Spacer(),
              StreamBuilder(
                  stream: profile.snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return GestureDetector(
                        child: CircleAvatar(
                            child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    snapshot.data.docs[0]['image']),
                              ),
                              borderRadius: BorderRadius.circular(20)),
                        )),
                      );
                    }
                    return Container();
                  }),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: StreamBuilder(
              stream: categories.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    itemCount: snapshot.data?.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final data = snapshot.data!.docs[index];

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SubGrid(
                                    name: data['name'],
                                  )));
                        },
                        child: Stack(
                          children: [
                            GlassContainer.clearGlass(height: 200, width: 200),
                            Positioned(
                              bottom: 10,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 45),
                                child: Text(data['name'],
                                    style: GoogleFonts.notoSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white)),
                              ),
                            ),
                            Positioned(
                              left: 10,
                              top: 20,
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
                          ],
                        ),
                      );
                    },
                  );
                }
                return Container();
              }),
        ),
      ),
    );
  }
}
