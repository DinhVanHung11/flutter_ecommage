import 'package:flutter/material.dart';

class ProductOptionModel extends ChangeNotifier
{ 
  String label;
  String value;
  int valueIndex;
  bool isSelected;

    ProductOptionModel({
    required this.label,
    required this.value,
    required this.valueIndex,
    required this.isSelected,
  });

  void toggleSelected(){
    isSelected = !isSelected;
    notifyListeners();
  }
}