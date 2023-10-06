// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:bbb/variables/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PopupFullContent extends StatelessWidget {
  PopupFullContent({super.key, this.html = ""});

  var html;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: Column(
          children: [
            Stack(
              children:[
                const Center(
                  child: Text(
                    'Chi tiết sản phẩm', style: TextStyle(
                      color: colorTheme, 
                      fontSize: 18, 
                      fontStyle: FontStyle.italic, 
                      fontWeight: FontWeight.w800
                    )
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Hero(
                        tag: "closemodalproductcontent",
                        child: SvgPicture.asset("assets/images/icon/icon-close.svg")
                      )
                    ),
                  )
                )
              ],
            ),
            const SizedBox(height: 20),
            Html(
              data: html,
            ),
          ],
        ),
      ),
    );
  }
}