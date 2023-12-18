// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';

class TabItems extends StatelessWidget {
  String name;
  TabItems({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GlassContainer(
      height: 35,
      elevation: 0,
      blur: 0,
      // gradient: LinearGradient(
      //     colors: [Colors.white.withOpacity(.9), Colors.white.withOpacity(.9)]),
      margin: const EdgeInsets.only(left: 5),
      borderRadius: BorderRadius.circular(30),
      color: Colors.white.withOpacity(.1),
      borderColor: Colors.white,
      width: size.width * .24,
      child: Center(
        child: Text(name.toString()),
      ),
    );
  }
}
