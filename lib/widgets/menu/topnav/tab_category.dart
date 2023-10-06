import 'package:bbb/variables/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class TabCategorySideBar extends StatelessWidget {
  TabCategorySideBar({
    super.key,
    required this.index
  });

  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: index == 1 ? const Color.fromRGBO(0, 0, 0, 0.1) : Colors.transparent,
            blurRadius: 10,
            offset: const Offset(0,0),
            blurStyle: BlurStyle.outer
          )
        ]
      ),
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/icon/icon-menu-white.svg", color: index == 0 ? colorWhite : colorBlack),
          const SizedBox(width: 10),
          const Text('Danh mục', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))
        ]
      )
    );
  }
}