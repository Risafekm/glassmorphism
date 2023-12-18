import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

AppBar appBAR(CollectionReference<Object?> profile, String name, bool isIcon,
    {PreferredSizeWidget? bottom, required VoidCallback ontap}) {
  return AppBar(
    //toolbar height koottiyal namuk appbar section te space koottam
    toolbarHeight: 125,
    automaticallyImplyLeading: false,
    backgroundColor: const Color.fromARGB(255, 59, 151, 227).withOpacity(.6),
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
                  backgroundColor: isIcon ? Colors.white : Colors.transparent,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: isIcon
                          ? GestureDetector(
                              onTap: ontap,
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Color.fromARGB(255, 15, 104, 177),
                                size: 18,
                              ),
                            )
                          : null),
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
                    child: CircleAvatar(
                        child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(snapshot.data.docs[0]['image']),
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
    // details page lek bottom value ne idukkan veendiyaanu ivide bottom koduthekkunnathu.
    // appo matte details page il bottom widget tree ye vilikkan pattum
    bottom: bottom,
  );
}
