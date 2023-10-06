// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:bbb/variables/color.dart';
import 'package:bbb/widgets/product/product_item.dart';
import 'package:flutter/material.dart';

class ProductPageRelated extends StatelessWidget {
  ProductPageRelated({
    super.key,
    this.products
  });

  var products;

  @override
  Widget build(BuildContext context) {
    return products.length > 0 ? Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: const Center(
            child: Text('Thường được mua cùng', 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, fontStyle: FontStyle.italic, color: colorTheme),
            )
          ),
        ),
        SizedBox(
          height: 328,
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, 
              mainAxisSpacing: 20, 
              childAspectRatio: 2.5
            ), 
            itemBuilder: (context, index) {
              var product = products[index];
              return ProductItem(product: product);
            },
          ),
        )
      ],
    ): const SizedBox();
  }
}
