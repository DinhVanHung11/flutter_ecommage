// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  ProductList({super.key, required this.products});
  var products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (context, index) {
            var product = products[index];
            return Container(
              width: 200,
              height: 200,
              color: Colors.amber,
            );
          },
        ),
    );
  }
}

