// ignore_for_file: must_be_immutable

import 'package:bbb/variables/color.dart';
import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  ButtonPrimary({
    super.key,
    required this.text,
    this.spacing = 5,
    this.isLoading = false
  });

  String text;
  double spacing;
  bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colorTheme
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLoading 
            ? const SizedBox( width: 25, height: 25, child: CircularProgressIndicator(color: colorWhite)) 
            : const SizedBox(),
          SizedBox(width: isLoading ? 15 : 0),
          Text( isLoading ? "Please wait..." : text, style: const TextStyle(color: colorWhite, fontSize: 16, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class ButtonSecondary extends StatelessWidget {
  ButtonSecondary({super.key, required this.text, this.isLoading = false});

  final String text;
  bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 30),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: colorTheme),
        borderRadius: BorderRadius.circular(30)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLoading 
            ? const SizedBox( width: 25, height: 25, child: CircularProgressIndicator(color: colorTheme, )) 
            : const SizedBox(),
          SizedBox(width: isLoading ? 15 : 0),
          Text( isLoading ? "Please wait..." : text, style: const TextStyle(color: colorTheme)),
        ],
      ) 
    );
  }
}
