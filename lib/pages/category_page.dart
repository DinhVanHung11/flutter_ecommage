// ignore_for_file: non_constant_identifier_names

import 'package:bbb/config/schema.dart';
import 'package:bbb/pages/category/category_products.dart';
import 'package:bbb/pages/category/categroy_heading.dart';
import 'package:bbb/variables/color.dart';
import 'package:bbb/widgets/appbar.dart';
import 'package:bbb/widgets/menu_sidebar.dart';
import 'package:bbb/widgets/sticky_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CategoryPage extends StatefulWidget {
  static const routeName = '/category';
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var currentPage = 1;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    var arguments = (ModalRoute.of(context)?.settings.arguments ?? <int, dynamic>{}) as Map;
    var id = arguments['id'];
    
    return Scaffold(
      backgroundColor: colorWhite,
      key: _scaffoldKey,
      drawer: const Drawer(
        width: double.infinity,
        backgroundColor: colorWhite,
        child: MenuSideBar()
      ),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget()
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, bottom: 80, left: 20, right: 20),
        child: Query(
          options: QueryOptions(
            document: gql(queryCategoryById),
            variables: {
              'id': id,  
              'currentPage': currentPage
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
            var totalCount = category["products"]?["total_count"];
            var pageSize = category["products"]?["page_info"]["page_size"];
        
            return Column(
              children: [
                CategoryPageHeading(categoryName: category['name']),
                CategoryPageProducts(products: products),
                CategoryPagePagination(totalCount, pageSize),
              ],
            );
          } 
        ),
      ),
      bottomSheet: Container(
        color: Colors.transparent,
        height: 80,
        child: StickyFooter(scaffoldKey: _scaffoldKey)
      )
    );
  }

  Row CategoryPagePagination(totalCount, pageSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (currentPage > 1) InkWell(
          onTap: () {
            setState(() {
              currentPage = currentPage - 1;
            });
          },
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 1, color: colorTheme),
            ),
            child:  Center(
              child: SvgPicture.asset("assets/images/icon/icon-arrow-left.svg")
            ),
          ),
        ),
        for(int i= 1; i <= (totalCount/pageSize).ceil(); i++)...[
          InkWell(
            onTap: (){
              setState(() {
                currentPage = i;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 1, color: currentPage == i ? colorTheme: colorBorder)
              ),
              child: Center(
                child: Text(
                  i.toString(), 
                  style:  TextStyle(
                    fontWeight: FontWeight.w600, 
                    color: currentPage == i ? colorTheme: colorBlack
                  )
                )
              ),
            ),
          ),
        ],
        if (currentPage < (totalCount/pageSize).ceil()) InkWell(
          onTap: () {
            setState(() {
              currentPage = currentPage + 1;
            });
          },
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 1, color: colorTheme),
            ),
            child:  Center(
              child: SvgPicture.asset("assets/images/icon/icon-arrow-right.svg", color: colorTheme)
            ),
          ),
        ),
      ],
    );
  }
}
