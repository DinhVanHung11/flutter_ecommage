import 'package:bbb/provider/add_to_cart_provider.dart';
import 'package:bbb/variables/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class AppBarActions extends StatelessWidget {
  const AppBarActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
  return Container(
      padding: const EdgeInsets.only(right: 20),
      child: Consumer<AddToCartProvider>(builder: (context, value, child) {
        return badges.Badge(
          badgeContent: Text(value.getCartTotal.toString(), style: const TextStyle(color: colorTheme)),
          position: badges.BadgePosition.topEnd(top: 6, end: -10),
          badgeColor: colorYellow,
          child: SizedBox(
            width: 25,
            height: 25,
            child: SvgPicture.asset("assets/images/icon/icon-minicart.svg")
          ),
        );
      })
    );
  }
}