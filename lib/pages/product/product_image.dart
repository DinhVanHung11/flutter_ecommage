// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:bbb/variables/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe/flutter_swipe.dart';

class ProductPageImages extends StatelessWidget {
  ProductPageImages({super.key, this.images});

  var images;
  
  @override
  Widget build(BuildContext context) {
    return images.length > 1 ? Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 388,
      width: double.infinity,
      child: Swiper(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Image(
            image: NetworkImage(images[index]["url"] ?? "https://images.unsplash.com/photo-1574328495409-33bc8aff6d56?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Y2hpbmElMjBnaXJsfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60"),
            fit: BoxFit.cover,
          );
        },
        pagination: const SwiperPagination(
          margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
          builder: DotSwiperPaginationBuilder(
            color: Color.fromRGBO(229, 26, 131, 0.3),
            activeColor: colorTheme,
            size: 7.0,
            activeSize: 7.0
          ),
        ),
      ),
    ) : const SizedBox();
  }
}