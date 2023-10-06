import 'package:bbb/Model/Product/option_model.dart';
import 'package:flutter/material.dart';

class ProductOptionProvider extends ChangeNotifier
{
  final List<ProductOptionModel> _items = [];

  List<ProductOptionModel> get items => [..._items];

  Future<List<ProductOptionModel>> addOption(options) async{
    for(int i =0; i < options.length; i++){
      for(int j = 0; j < options[i]["values"].length; j++){
        _items.add(ProductOptionModel(
          label: options[i]["label"], 
          value: options[i]["values"][j]["label"], 
          valueIndex: options[i]["values"][j]["value_index"], 
          isSelected: false
        ));
      }
    }
    
    return _items;
  }

  getListByLabel(var options, String label){
    return options.where((element) => element.label == label).toList();
  }
}