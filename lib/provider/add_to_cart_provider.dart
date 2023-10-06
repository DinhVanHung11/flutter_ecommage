

import 'package:bbb/Schemas/url_end_point.dart';
import 'package:bbb/config/mutation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddToCartProvider extends ChangeNotifier
{
  final EndPoint _point = EndPoint();

  bool _submitting = false;
  bool get getStatusSubmit => _submitting;

  String _cartId = "";
  String get getCartId => _cartId;

  String _message = "";
  String get getMessage => _message;

  List _carts = [];
  List get getCarts => _carts;

  int _cartTotal = 0;
  int get getCartTotal => _cartTotal;

  Future<bool> createEmptyCart() async{
    _submitting = true;

    ValueNotifier<GraphQLClient> client = _point.getClient();
    QueryResult result = await client.value.mutate(
      MutationOptions(document: gql(CreateEmptyCart))
    );

    if(result.hasException){
      _submitting = false;

      if(result.exception!.graphqlErrors.isEmpty){
        _message = "Inter net is not found";
      }else{
        _message = result.exception!.graphqlErrors[0].message.toString();
      }
      notifyListeners();

      return false;
    }else{
      _cartId = result.data?["createEmptyCart"];
      _submitting = false;
      notifyListeners();
    }

    return true;
  }

  Future<bool> addToCart({String? sku, double? quantity}) async{
    _submitting = true;

    notifyListeners();

    ValueNotifier<GraphQLClient> client = _point.getClient();
    QueryResult result = await client.value.mutate(
      MutationOptions(document: 
        gql(AddSimpleProductToCart),
        variables: {
          'cartId': _cartId,
          'qty': quantity,
          'sku' : sku
        }
      )
    );

    if(result.hasException){
      _submitting = false;

      if(result.exception!.graphqlErrors.isEmpty){
        _message = "Inter net is not found";
      }else{
        _message = result.exception!.graphqlErrors[0].message.toString();
        print(_message);
      }

      notifyListeners();
      return false;
    }else{
      _carts = result.data?["addSimpleProductsToCart"]["cart"]["items"];
      handleCartTotal(_carts);
      _message = "";
      _submitting = false;
      print(_carts);

      notifyListeners();
    }

    return true;
  }

  Future<bool> addConfigProductToCart({String? parentSku, String? sku, double? quantity}) async{
    _submitting = true;
    notifyListeners();

    ValueNotifier<GraphQLClient> client = _point.getClient();
    QueryResult result = await client.value.mutate(
      MutationOptions(document: 
        gql(AddConfigruationProductToCart),
        variables: {
          'cartId': _cartId,
          'qty': quantity,
          'parentSku': parentSku,
          'sku' : sku
        }
      )
    );

    if(result.hasException){
      _submitting = false;

      if(result.exception!.graphqlErrors.isEmpty){
        _message = "Inter net is not found";
      }else{
        _message = result.exception!.graphqlErrors[0].message.toString();
        print(_message);
      }

      notifyListeners();
      return false;
    }else{
      _carts = result.data?["addConfigurableProductsToCart"]["cart"]["items"];
      handleCartTotal(_carts);
      _message = "";
      _submitting = false;
      print(_carts);

      notifyListeners();
    }

    return true;
  }

  void handleCartTotal(List carts){
    if(carts.isEmpty){
      _cartTotal = 0;
    }else{
      _cartTotal = 0;
      for(int i = 0; i < carts.length; i++){
        int qty = carts[i]["quantity"];
        _cartTotal += qty;
      }
    }

    notifyListeners();
  }
}