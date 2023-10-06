// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, prefer_const_constructors


import 'package:bbb/variables/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductRating extends StatelessWidget {
  ProductRating({
    super.key,
    this.rating = 0,
    this.marginBottom = 15
  });

  var rating;
  double marginBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom),
      height: 21,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if(index <= rating - 1){
            return SizedBox(width: 20, child: SvgPicture.asset("assets/images/icon/icon-star.svg", color: colorYellow2));
          }
          return SizedBox(width: 20, child: SvgPicture.asset("assets/images/icon/icon-star.svg", color: colorBorder));
        }, 
        separatorBuilder: (context, index) {
          return SizedBox(width: 5);
        }, 
      ),
    );
  }
}

String getVariantSku({data, optionsSelected}) {
  bool rejected = false;
  var options = optionsSelected as List;
  options.sort((a, b) => a.label.toUpperCase().compareTo(b.label.toUpperCase()));
  var variants = data as List;
  for(int i = 0; i < variants.length; i++){
    var attributes = variants[i]["attributes"];
    rejected = false;

    if(attributes.length == options.length){
      for(int j = 0; j < attributes.length ; j++){
        if(attributes[j]["code"].toLowerCase() != options[j].label.toLowerCase()){
          rejected = true;
          continue;
        }

        if(attributes[j]["value_index"] != options[j].valueIndex){
          rejected = true;
          continue;
        }
      }

      if(!rejected){
        return variants[i]["product"]["sku"];
      }
    }
  }

  return "";
}

