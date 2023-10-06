import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier{
  final _categories = [];

  dynamic get categories{
    return [..._categories];
  }
}