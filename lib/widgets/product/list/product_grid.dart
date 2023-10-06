// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:bbb/widgets/product/product_item.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  ProductGrid({super.key, required this.products});
  var products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        childAspectRatio: 0.6
      ),
      itemBuilder: (context, index) {
        var product = products[index];
        return ProductItem(product: product);
      }
    );
  }
}

