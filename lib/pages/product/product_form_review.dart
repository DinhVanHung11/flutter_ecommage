// ignore_for_file: must_be_immutable, void_checks

import 'package:bbb/Components/button.dart';
import 'package:bbb/Components/input.dart';
import 'package:bbb/config/mutation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProductPageFormReview extends StatefulWidget {
  ProductPageFormReview({
    super.key,
    required this.name,
    required this.sku
  });

  String name;
  String sku;

  @override
  State<ProductPageFormReview> createState() => _ProductPageFormReviewState();
}

class _ProductPageFormReviewState extends State<ProductPageFormReview> {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController summaryController= TextEditingController();
  TextEditingController reviewController = TextEditingController();
  bool isSubmitting = false;
  dynamic errorMessage = "";


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        const Text("You are reviewing: ", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 3),
        Text(widget.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 20),
        GroupFiledInput(label: "Nickname", obscureText: false, controller: nicknameController),
        GroupFiledInput(label: "Summary", obscureText: false, controller: summaryController),
        GroupFiledInput(label: "Review", obscureText: false, controller: reviewController, height: 80, maxLines: 5, textInputType: TextInputType.multiline),
        Mutation(
          options: MutationOptions(
            document: gql(CreateProductReview),
            update: (cache, result) {
              return cache;
            },
            onCompleted: (data) {
              setState(() {
                isSubmitting = false;
              });
              
              if(data.runtimeType != Null){

              }else{
              }
            },
            onError: (error) {
              setState(() {
                errorMessage = error?.graphqlErrors[0].message;
              });
            },
          ), 
          builder: (runMutation, result) {
            return InkWell(
              onTap: () {
                runMutation({
                  'sku' : widget.sku,
                  'nickname' : nicknameController.text,
                  'summary' : summaryController.text,
                  'text' : reviewController.text
                });
                setState(() {
                  isSubmitting = true;
                });
              },
              child: ButtonPrimary(text: "Submit Review", isLoading: isSubmitting)
            );
          },
        )
      ],
    );
  }
}