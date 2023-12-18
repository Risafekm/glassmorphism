// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';

//tab bar widget ne refactor cheyyan veendiya seperate aayi viliche
//angane cheyyumbol code repeatation kurakkam

class TabItems extends StatelessWidget {
  String name;
  TabItems({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GlassContainer.clearGlass(
      height: 35,
      width: size.width * .24,
      elevation: 0,
      blur: 0,
      gradient: LinearGradient(colors: [
        Colors.white.withOpacity(.1),
        Colors.white.withOpacity(.1),
      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      margin: const EdgeInsets.only(left: 5),
      borderRadius: BorderRadius.circular(10),
      borderColor: Colors.white60,
      child: Center(
        child: Text(name.toString()),
      ),
    );
  }
}
