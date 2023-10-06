// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:bbb/widgets/product/list/product_grid.dart';
import 'package:flutter/material.dart';

class CategoryPageProducts extends StatelessWidget {
  CategoryPageProducts({super.key, required this.products});
  var products;

  @override
  Widget build(BuildContext context) {
    return ProductGrid(products: products);
  }
}