// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:bbb/config/schema.dart';
import 'package:bbb/variables/color.dart';
import 'package:bbb/widgets/product/product_item.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProductPageBestSeller extends StatelessWidget {
  const ProductPageBestSeller({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: const Center(
            child: Text('Sản phẩm bán chạy', 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, fontStyle: FontStyle.italic, color: colorTheme),
            )
          ),
        ),
        Query(
          options: QueryOptions(
            document: gql(queryCategoryById),
            variables: const {
              'id': 3,  
              'currentPage': 1
            }
          ),
          builder: (result, {fetchMore, refetch}) {
            if(result.hasException){
              return Text(result.exception.toString());
            }
            if(result.isLoading){
              return const Center(child: CircularProgressIndicator());
            }   
        
            var category = result.data?["category"];
            var products = category["products"]?["items"];
        
            return SizedBox(
              height: 328,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 4,
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
            );
          } 
        ),
      ],
    );
  }
}
