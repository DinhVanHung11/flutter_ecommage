import 'package:bbb/Utils/url.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EndPoint{
  ValueNotifier<GraphQLClient> getClient(){
        ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: HttpLink(endpointUrl),

        cache: GraphQLCache(store: InMemoryStore()),
      )
    );

    return client;
  }
}