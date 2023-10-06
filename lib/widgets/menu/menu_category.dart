import 'package:bbb/config/schema.dart';
import 'package:bbb/pages/category_page.dart';
import 'package:bbb/variables/color.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MenuCategory extends StatefulWidget {
  const MenuCategory({
    super.key,
  });

  @override
  State<MenuCategory> createState() => _MenuCategoryState();
}

class _MenuCategoryState extends State<MenuCategory> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Query(
        options: QueryOptions(
          document: gql(queryCategories),
          variables: const {
            'level': '2',
            'id': ''
          }
        ), 
        builder: (result, {fetchMore, refetch}) {
          if(result.hasException){
            return Text(result.exception.toString());
          }
          if(result.isLoading){
            return const Center(child: CircularProgressIndicator());
          }              
          var dataCategoryLv2 = result.data?["categoryList"][0]["children"];
          
          return ListView.builder(
            
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dataCategoryLv2.length,
            itemBuilder: (context, index) {
              var categoryIdLv2 = dataCategoryLv2[index]["id"];
              var imageUrl = dataCategoryLv2[index]["image"] ?? "https://images.unsplash.com/photo-1685972215665-80580c58e4ee?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1197&q=80";
              // var isExpanded = false;
              return ExpansionTile(
                tilePadding: const EdgeInsets.all(0),
                childrenPadding: const EdgeInsets.only(bottom: 15, left: 30),
                textColor: colorTheme,
                iconColor: colorTheme,
                title: InkWell(
                  onTap: (){
                    Navigator.popAndPushNamed(context, CategoryPage.routeName, arguments: {
                      'id': categoryIdLv2
                    });
                  },
                  child: Hero(
                    tag: "btntocatgory$categoryIdLv2",
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.network(imageUrl, fit: BoxFit.cover)
                        ),
                        const SizedBox(width: 10),
                        Text(dataCategoryLv2[index]["name"], style: const TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
                trailing: dataCategoryLv2[index]["children"].length > 0 ? const Icon(Icons.arrow_forward_ios, size: 16) : const SizedBox(),
                children: [
                  Query(
                    options: QueryOptions(
                      document: gql(queryCategories), 
                      variables: {
                        'level': '2',
                        'id': '$categoryIdLv2'
                      }
                    ),
                    builder:(result, {fetchMore, refetch}) {
                      if(result.hasException){
                        return Text(result.exception.toString());
                      }
                      if(result.isLoading){
                        return const Center(child: CircularProgressIndicator());
                      }  
                      var dataCategoryLv3 = result.data?["categoryList"][1]["children"];

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: dataCategoryLv3.length,
                        itemBuilder: (context, index) {
                          var dataCategoryLv4 = dataCategoryLv3[index]["children"];
                          var categoryIdLv3 = dataCategoryLv3[index]['id'];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.popAndPushNamed(context, CategoryPage.routeName, arguments: {
                                    'id': categoryIdLv3
                                  });
                                },
                                child: Hero(
                                  tag: "btntocatgory$categoryIdLv3",
                                  child: Text(dataCategoryLv3[index]["name"], style: const TextStyle(fontWeight: FontWeight.w600))
                                )
                              ),
                              const SizedBox(height: 5),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: dataCategoryLv4.length,
                                itemBuilder: (context, index) {
                                  var categoryIdLv4 = dataCategoryLv4[index]['id'];
                                  return InkWell(
                                    onTap: (){
                                      Navigator.popAndPushNamed(context, CategoryPage.routeName, arguments: {
                                        'id': categoryIdLv4
                                      });
                                    },
                                    child: Hero(
                                      tag: "btntocatgory$categoryIdLv4",
                                      child: Text(dataCategoryLv4[index]["name"])
                                    )
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 3);
                                }
                              )
                            ]
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 20);
                        }
                      );
                    }
                  )
                ]
              );
            }
          );
        }
      )
    );
  }
}