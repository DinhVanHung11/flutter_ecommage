// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, import_of_legacy_library_into_null_safe

import 'package:bbb/variables/color.dart';
import 'package:bbb/widgets/popup/popup_full_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductPageContent extends StatelessWidget {
  ProductPageContent({super.key, this.html = ""});

  var html;

  @override
  Widget build(BuildContext context) {
    var htmlDisplay = html.length > 350 ? html.substring(0,350) + "..." : html;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 20),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: colorBorder))
          ),
          child: const Center(
            child: Text(
              'Chi tiết sản phẩm', style: TextStyle(
                color: colorTheme, 
                fontSize: 16, 
                fontStyle: FontStyle.italic, 
                fontWeight: FontWeight.w800
              )
            ),
          )
        ),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Html(data: htmlDisplay);
          }
        ),
        Container(
          width: 130,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  width: 1,
                  color: colorCustom2
              )
          ),
          child: InkWell(
            onTap: (){
              showDialog(context: context, builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: colorWhite,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: PopupFullContent(html: html)
                  ),
                );
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Show more", style: TextStyle(color: colorText, fontSize: 14, fontWeight: FontWeight.w600),),
                const SizedBox(
                  width: 5,
                ),
                SvgPicture.asset("assets/images/icon/icon-arrow-down.svg")
              ],
            ),
          ),
        ),
        const SizedBox(height: 25,)
      ],
    );
  }
}