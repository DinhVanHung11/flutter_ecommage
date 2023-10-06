import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier{
  final String _cartId = "";

  String get carId{
    return _cartId;
  }
}