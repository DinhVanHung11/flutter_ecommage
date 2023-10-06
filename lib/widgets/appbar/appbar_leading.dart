import 'package:bbb/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarLeading extends StatelessWidget {
  const AppBarLeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 32,
      padding: const EdgeInsets.only(left: 20),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, HomePage.routeName);
        },
        child: Hero(
          tag: "logotohome",
          child: SvgPicture.asset("assets/images/icon/logo.svg", fit: BoxFit.contain)
        )
      ),
    );
  }
}