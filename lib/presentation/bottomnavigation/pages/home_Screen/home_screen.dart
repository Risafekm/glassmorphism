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

              //profile pic

              StreamBuilder(
                  stream: profile.snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return GestureDetector(
                        onTap: () {
                          showGeneralDialog(
                            context: context,
                            pageBuilder: (BuildContext context,
                                Animation animation, Animation animation1) {
                              return Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 40),
                                  child: GlassContainer.clearGlass(
                                    height: 250,
                                    width: 230,
                                    borderRadius: BorderRadius.circular(20),
                                    borderColor: Colors.white,
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withOpacity(.5),
                                        Colors.white.withOpacity(.3),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10, top: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              cancelIcon(context),
                                              profileAvatar(snapshot, size: 18),
                                            ],
                                          ),
                                        ),
                                        iconTextSHowGeneral(
                                            name: 'Your Profile',
                                            icon: Icons.person),
                                        iconTextSHowGeneral(
                                            name: 'Change Mode',
                                            icon: Icons.change_circle),
                                        iconTextSHowGeneral(
                                            name: 'Subscriptions',
                                            icon: Icons.subscriptions),
                                        iconTextSHowGeneral(
                                            name: 'Logout', icon: Icons.logout),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: profileAvatar(snapshot, size: 20),
                      );
                    }
                    return Container();
                  }),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),

          // GlassContainer area images
          child: StreamBuilder(
              stream: categories.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.amber));
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error Loading'));
                } else if (snapshot.hasData) {
                  return gridViewWidget(snapshot);
                }
                return Container();
              }),
        ),
      ),
    );
  }

  Widget iconTextSHowGeneral({required String name, required IconData icon}) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    name,
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 5,
                left: 10,
                child: Container(
                  width: 150,
                  height: 2,
                  color: Colors.white54,
                )),
          ],
        ),
      ],
    );
  }

  Widget profileAvatar(AsyncSnapshot<dynamic> snapshot,
      {required double size}) {
    return CircleAvatar(
      radius: size,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(snapshot.data.docs[0]['image']),
            ),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget cancelIcon(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Icon(
        Icons.cancel,
        color: Colors.white,
        size: 32,
      ),
    );
  }

  Widget gridViewWidget(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SubGrid(
                  name: data['name'],
                ),
              ),
            );
          },
          child: Stack(
            children: [
              GlassContainer.clearGlass(height: 200, width: 200),
              Positioned(
                bottom: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
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
}
