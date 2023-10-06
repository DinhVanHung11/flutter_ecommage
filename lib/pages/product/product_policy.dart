// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProductPagePolicy extends StatelessWidget {
  const ProductPagePolicy({super.key});

  @override
  Widget build(BuildContext context) {
    const queryCmsBlockPolicy = '''
      {
        cmsBlocks(identifiers: "pdp_rightsidebar") {
          items {
            identifier
            title
            content
          }
        }
      }
    ''';
    return Query(
      options: QueryOptions(
        document: gql(queryCmsBlockPolicy),

      ),
      builder: (result, {fetchMore, refetch}) {
        if(result.hasException){
          return Text(result.exception.toString());
        }
        if(result.isLoading){
          return const Center(child: CircularProgressIndicator());
        }   

        var data = result.data?["cmsBlocks"]["items"][0]["content"];
        return Html(
          data: data,
          
        );
      },
    );
  }
}