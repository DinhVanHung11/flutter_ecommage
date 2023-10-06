// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  ErrorMessage({
    super.key,
    required this.errorMessage,
    this.marginBottom = 20
  });

  final errorMessage;
  double marginBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom),
      child: Center(
        child: Text(errorMessage, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
      ),
    );
  }
}