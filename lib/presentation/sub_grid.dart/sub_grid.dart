// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:glassmorphism/application/services/api.dart';
import 'package:glassmorphism/domain/const_values.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/home_Screen/tab_pages/rent.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/home_Screen/tab_pages/sales.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/home_Screen/tab_pages/services.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/home_Screen/tab_pages/sharing.dart';
import 'package:glassmorphism/presentation/bottomnavigation/pages/home_Screen/widgets/tab_items.dart';
import 'package:google_fonts/google_fonts.dart';

class SubGrid extends StatelessWidget {
  SubGrid({super.key, required this.name});

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
        appBar: AppBar(
          //toolbar height koottiyal namuk appbar section te space koottam
          toolbarHeight: 125,
          automaticallyImplyLeading: false,
          backgroundColor:
              const Color.fromARGB(255, 59, 151, 227).withOpacity(.6),
          title: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  const SizedBox(height: 70),
                  Row(
                    children: [
                      //ivide aanu aa home page le names ilikkunne.avidennu pass
                      // cheytha data aanu namma ivide access cheyyunne
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Color.fromARGB(255, 15, 104, 177),
                                size: 18,
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ),
              //appbar nte top area (leading kodukkathe ingane koduthu)
              const Positioned(
                top: 10,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.dashboard,
                        color: Colors.white,
                        size: 26,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Hi',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ),

              //profile pic area
              Positioned(
                top: 5,
                right: 0,
                child: StreamBuilder(
                    stream: profile.snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return GestureDetector(
                          onTap: () {
                            //profiel area dialog box
                            profileDialogBox(context, snapshot);
                          },
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
              ),
            ],
          ),

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
        ),

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
  // profile Dialogbox

  Future<Object?> profileDialogBox(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return showGeneralDialog(
      context: context,
      pageBuilder:
          (BuildContext context, Animation animation, Animation animation1) {
        return Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
            child: GlassContainer.clearGlass(
              height: 260,
              width: 250,
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
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        cancelIcon(context),
                        profileAvatar(snapshot, size: 18),
                      ],
                    ),
                  ),
                  iconTextSHowGeneral(
                      name: 'Your Profile', icon: Icons.person, ontap: () {}),
                  iconTextSHowGeneral(
                      name: 'Change Mode',
                      icon: Icons.change_circle,
                      ontap: () {}),
                  iconTextSHowGeneral(
                      name: 'Subscriptions',
                      icon: Icons.subscriptions,
                      ontap: () {
                        subcriptionUiGlass(context)
                            .then((value) => Navigator.pop(context));
                      }),
                  iconTextSHowGeneral(
                      name: 'Logout',
                      icon: Icons.logout,
                      ontap: () {
                        Api.signOut();
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Subcriptions ui glass

  Future<Object?> subcriptionUiGlass(
    BuildContext context,
  ) {
    return showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, animation1) {
          return GlassContainer.clearGlass(
            height: 300,
            width: 320,
            borderRadius: BorderRadius.circular(40),
            borderColor: Colors.white,
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(.2),
                Colors.white.withOpacity(.2),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 38),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Subcriptions',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.cancel,
                          size: 32,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 260,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 11, 61, 103),
                      ),
                    ),
                    child: const Text(
                      'Remove ads for 1 month       6 QR',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 260,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 11, 61, 103),
                      ),
                    ),
                    child: const Text(
                      'Remove ads for 1 year       60 QR',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 260,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 11, 61, 103),
                      ),
                    ),
                    child: const Text(
                      'Continue with ads      0 QR',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget iconTextSHowGeneral(
      {required String name,
      required IconData icon,
      required VoidCallback ontap}) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: TextButton(
                onPressed: ontap,
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
                      style:
                          const TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 15,
              child: Container(
                width: 150,
                height: 2,
                color: Colors.white54,
              ),
            ),
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
