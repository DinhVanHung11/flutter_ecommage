// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:bbb/variables/color.dart';
import 'package:flutter/material.dart';

class GroupFiledInput extends StatelessWidget {
  GroupFiledInput({
    super.key,
    required bool obscureText,
    required this.controller,
    required this.label,
    this.textInputType = TextInputType.text,
    this.maxLines = 1,
    this.height = 30,
    this.marginBottom = 20
  }) : _obscureText = obscureText;

  final bool _obscureText;
  final String label;
  final controller;
  double marginBottom;
  TextInputType textInputType;
  int maxLines;
  double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(margin: const EdgeInsets.only(bottom: 10), child: Text(label)),
          Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 1, color: colorBorder)
            ),
            child: TextField(
              keyboardType: textInputType,
              maxLines: maxLines,
              obscureText: _obscureText,
              controller: controller,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0, style: BorderStyle.none)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}