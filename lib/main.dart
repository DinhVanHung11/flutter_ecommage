import 'package:bbb/Utils/url.dart';
import 'package:bbb/pages/category_page.dart';
import 'package:bbb/pages/home_page.dart';
import 'package:bbb/pages/product_page.dart';
import 'package:bbb/provider/category_provider.dart';
import 'package:bbb/provider/product_option_provider.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'provider/add_to_cart_provider.dart';

void main(){
  final HttpLink httpLink = HttpLink(endpointUrl);
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );

  runApp(GraphQLProvider(
    client: client,
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => AddToCartProvider()),
        ChangeNotifierProvider(create: (_) => ProductOptionProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          CategoryPage.routeName: (context) => const CategoryPage(),
          ProductPage.routeName: (context) => const ProductPage()
        },
      ),
    ),
  ));
}


