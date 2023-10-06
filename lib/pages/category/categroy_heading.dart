import 'package:bbb/variables/color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryPageHeading extends StatelessWidget {
  CategoryPageHeading({
    super.key,
    this.mb = 20,
    required this.categoryName
  });

  String categoryName;
  final double mb;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            margin: EdgeInsets.only(bottom: mb),
            decoration: const BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(60), bottomRight: Radius.circular(60))
            ),
            child: Text(categoryName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: colorTheme))
          )
        ),
      ],
    );
  }
}