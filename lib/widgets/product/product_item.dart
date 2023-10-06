import 'package:bbb/pages/product_page.dart';
import 'package:bbb/variables/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class ProductItem extends StatelessWidget {
  ProductItem({super.key, required this.product});
  // ignore: prefer_typing_uninitialized_variables
  var product;
  
  @override
  Widget build(BuildContext context) {
    var productId = product["id"];
    var productType = product["__typename"];
    var productImage = product["image"]["url"];
    var productName = product["name"];
    var productOldPrice = product["price_range"]["maximum_price"]["regular_price"]["value"];
    var specialPrice = product["special_price"];
    var productFinalPrice = product["price_range"]["maximum_price"]["final_price"]["value"];
    return Column(children: [
      Expanded(
        flex: 1,
        child: Hero(
          tag: "btntoproduct$productId",
          child: InkWell(
            onTap: (){
              Navigator.pushNamed(context, ProductPage.routeName, arguments: {
                "sku": product['sku']
              });
            },
            child: Image.network(productImage, fit: BoxFit.cover)
          ),
        ),
      ),
      const SizedBox(height: 10),
      Expanded(
        flex: 1,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(productName, maxLines: 2 , overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 5),
          Text(productFinalPrice.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          specialPrice != null ? Container(
            margin: const EdgeInsets.only(bottom: 5, top: 5),
            child: Text(productOldPrice.toString(), style: const TextStyle(fontSize: 10, decoration: TextDecoration.lineThrough))
          ) : const SizedBox(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            productType == "SimpleProduct" ? Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: colorTheme,
                borderRadius: BorderRadius.circular(20)
              ),
              child: const Text('-20%', style: TextStyle(fontSize: 10, color: colorWhite))
            ) : const SizedBox(),
            SvgPicture.asset("assets/images/icon/icon-addtocart.svg")
          ])
        ])
      )
    ]);
  }
}