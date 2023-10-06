// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:bbb/variables/color.dart';
import 'package:flutter/material.dart';

class ProductPageInfo extends StatelessWidget {
  ProductPageInfo({super.key, this.name = '', this.price = 0, this.final_price, this.sku = ''});

  var name;
  var price;
  var final_price;
  var sku;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700))
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 22),
          child: Row(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 2),
                    child: const Text("Mã sản phẩm:", style: TextStyle(fontSize: 12, color: colorCustom))
                  ),
                  Text(sku, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                ],
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorCustom1,
            borderRadius: BorderRadius.circular(10)
          ),
          child: final_price!=0 ? Row(
            children: [
              Text(final_price.toString(), style: const TextStyle(color: colorTheme, fontSize: 20, fontWeight: FontWeight.w700)),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Text(
                  price.toString(), 
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, decoration: TextDecoration.lineThrough)
                )
              ),
            ],
          ) : Text(price.toString(), style: const TextStyle(color: colorTheme, fontSize: 20, fontWeight: FontWeight.w700)),
        )
      ],
    );
  }
}