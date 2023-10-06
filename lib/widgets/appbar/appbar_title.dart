
import 'package:bbb/variables/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                hintText: 'Tìm kiếm sản phẩm',
                border: OutlineInputBorder(borderSide: BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 5), 
            width: 24,
            height: 24,
            child: SvgPicture.asset("assets/images/icon/icon-search.svg"),
          )
        ],
      ),
    );
  }
}