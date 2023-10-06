// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:bbb/variables/color.dart';
import 'package:bbb/widgets/product/product_review_item.dart';
import 'package:flutter/material.dart';

class ProductPageReviews extends StatelessWidget {
  ProductPageReviews({super.key, this.reviews});

  var reviews;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: const Center(
            child: Text('Đánh giá sản phẩm', 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, fontStyle: FontStyle.italic, color: colorTheme),
            )
          ),
        ),
        Column(children: [
          for(int i= 0; i < reviews.length; i++)...[
            ProductReviewItem(review: reviews[i])
          ]
        ]
        )
      ],
    );
  }
}

