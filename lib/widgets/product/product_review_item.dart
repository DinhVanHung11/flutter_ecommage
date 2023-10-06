// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:bbb/Utils/mixins.dart';
import 'package:bbb/variables/color.dart';
import 'package:flutter/material.dart';

class ProductReviewItem extends StatelessWidget {
  ProductReviewItem({
    super.key,
    this.review
  });

  var review;

  @override
  Widget build(BuildContext context) {
    String nickname = review["nickname"];
    String time = review["created_at"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: Text(review["summary"], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600))
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 21, child: Text("Rating")),
            const SizedBox(width: 20),
            ProductRating(rating: review["average_rating"]/20),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: Text(review["text"])
        ),
        Text("Review by $nickname Posted on $time", style: const TextStyle(fontStyle: FontStyle.italic)),
        Container(
          width: double.infinity,
          height: 20, 
          margin: const EdgeInsets.only(bottom: 20),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: colorBorder))
          )
        )
      ],
    );
  }
}