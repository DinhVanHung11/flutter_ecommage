// ignore_for_file: void_checks, avoid_print, non_constant_identifier_names, unused_import, prefer_const_constructors

import 'package:bbb/Components/button.dart';
import 'package:bbb/Components/input.dart';
import 'package:bbb/Model/Product/option_model.dart';
import 'package:bbb/Utils/mixins.dart';
import 'package:bbb/config/schema.dart';
import 'package:bbb/pages/product/product_best_seller.dart';
import 'package:bbb/pages/product/product_form_review.dart';
import 'package:bbb/pages/product/product_image.dart';
import 'package:bbb/pages/product/product_info.dart';
import 'package:bbb/pages/product/product_related.dart';
import 'package:bbb/pages/product/product_review.dart';
import 'package:bbb/provider/add_to_cart_provider.dart';
import 'package:bbb/provider/product_option_provider.dart';
import 'package:bbb/variables/color.dart';
import 'package:bbb/Utils/extensions.dart';
import 'package:bbb/widgets/appbar.dart';
import 'package:bbb/widgets/menu_sidebar.dart';
import 'package:bbb/widgets/sticky_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'product/product_content.dart';

class ProductPage extends StatefulWidget {
  static const routeName = '/product';
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double countQuantity = 1;
  bool isSubmitting = false;
  dynamic errorMessage = "";
  List<ProductOptionModel> productOptions = <ProductOptionModel>[];
  List<ProductOptionModel> optionsSelected = <ProductOptionModel>[];

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var arguments = (ModalRoute.of(context)?.settings.arguments ?? <int, dynamic>{}) as Map;
    var sku = arguments['sku'];
    productOptions=[];

    void handleAddOptions(options){
      for(int i =0; i < options.length; i++){
        for(int j = 0; j < options[i]["values"].length; j++){
          productOptions.add(ProductOptionModel(
            label: options[i]["label"], 
            value: options[i]["values"][j]["label"], 
            valueIndex: options[i]["values"][j]["value_index"], 
            isSelected: false
          ));
        }
      }
    }

    List<ProductOptionModel> getOptionsByLabel(productOptions, label){
      return productOptions.where((item) => item.label == label).toList();
    }

    ProductOptionModel getOptionsSelected(productOptions){
      return productOptions.singleWhere((item) => item.isSelected == true);
    }

    void addSelectedOption(item){
      optionsSelected.removeWhere((element) => element.label == item.label);
      optionsSelected.add(item);
    }

    bool isSelectedOption(optionsSelected, valueIndex){
      var array = optionsSelected as List;
      var result  = array.where((element) => element.valueIndex == valueIndex);
      return result.isNotEmpty ? true : false;
    }

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
            document: gql(queryProductSku),
            variables: {
              'sku': sku,  
            }
          ),
          builder: (result, {fetchMore, refetch}) {
            if(result.hasException){
              return Text(result.exception.toString());
            }
            if(result.isLoading){
              return const Center(child: CircularProgressIndicator());
            }   

            var product = result.data?["products"]?["items"][0];
            var type = product["__typename"];
            var name = product["name"];
            var images = product["media_gallery"];
            var relateds = product["related_products"];
            var reviews = product["reviews"]["items"];
            var options = product?["configurable_options"];
            var variants = product?["variants"];

            if(type == "ConfigurableProduct"){
              handleAddOptions(options);
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductPageImages(images: images),
                ProductPageInfo(
                  sku: sku,
                  name: name,
                  price: product["price_range"]["maximum_price"]["regular_price"]["value"],
                  final_price: product["price_range"]["maximum_price"]["final_price"]["value"],
                ),
                type == "ConfigurableProduct" 
                ? ProductPageConfigOption(options, getOptionsByLabel, addSelectedOption, getOptionsSelected, isSelectedOption) : SizedBox(),
                ProductPageActions(sku, optionsSelected, variants, type),
                ProductPageContent(html: product["description"]["html"]),
                ProductPageRelated(products: relateds),
                ProductPageBestSeller(),
                ProductPageReviews(reviews: reviews),
                ProductPageFormReview(name: name, sku: sku)
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

  ListView ProductPageConfigOption(options, List<ProductOptionModel> Function(dynamic productOptions, dynamic label) getOptionsByLabel, void Function(dynamic item) addSelectedOption, ProductOptionModel Function(dynamic productOptions) getOptionsSelected, bool Function(dynamic optionsSelected, dynamic valueIndex) isSelectedOption) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: options.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        String optionLabel = options[index]["label"];
        List<ProductOptionModel> listValues = getOptionsByLabel(productOptions, optionLabel);

        return Container(
          padding: EdgeInsets.symmetric(vertical: 22),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: colorBorder))
          ),
          child: Row(
            children: [
              SizedBox(
                width: 55,
                child: Text(optionLabel),
              ),
              Expanded(flex: 1, child: GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics:  NeverScrollableScrollPhysics(),
                itemCount: listValues.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: optionLabel == "Color" ? 30 : 60,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 20,
                  childAspectRatio:optionLabel == "Color" ? 1 : 2
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {                                    
                        for (var element in listValues) {
                          element.isSelected = false;
                        }
                        listValues[index].isSelected = true;
                        addSelectedOption(getOptionsSelected(listValues));
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: optionLabel == "Color" ?  listValues[index].value.toColor() : Colors.transparent,
                        border: Border.all(
                          width: isSelectedOption(optionsSelected, listValues[index].valueIndex) ? 2 : 1, 
                          color: isSelectedOption(optionsSelected, listValues[index].valueIndex) ? colorTheme : colorBorder
                        ),
                        borderRadius: optionLabel == "Color" ? BorderRadius.circular(5) : BorderRadius.circular(20)
                      ),
                      child: optionLabel == "Color" ? SizedBox() :Center(child: 
                        Text(listValues[index].value, 
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)
                        )
                      ),
                    ),
                  );
                },
              ))
            ],
          ),
        );
      },
    );
  }

  Container ProductPageActions(sku, optionsSelected, data, type) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<AddToCartProvider>(builder: (context, value, child) {
            String errorMessage = value.getMessage;
            return Container(
              margin: EdgeInsets.only(bottom: errorMessage == "" ? 0 : 15),
              child: Text(errorMessage, style: const TextStyle(color: collorError)),
            );
          }),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              flex: 125,
              child: Container(
                padding: const EdgeInsets.all(5),
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: colorBorder),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  ButtonDecrement(),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Center(
                      child: Text(countQuantity.toInt().toString())
                    )
                  ),
                  ButtonIncrement()
                ]),
              )
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 243,
              child: ButtonPrimary(text: 'Mua ngay'),
            )
          ]),
          const SizedBox(height: 20),
          Consumer<AddToCartProvider>(builder: (context, value, child) {
            return InkWell(
              onTap: () async{
                var skuVariant = "";
                if(type == "ConfigurableProduct"){
                  skuVariant = getVariantSku(data: data, optionsSelected: optionsSelected);
                }

                if(value.getCartId == ""){
                  await value.createEmptyCart();
                } 

                if(type == "ConfigurableProduct"){
                  await value.addConfigProductToCart(sku: skuVariant, quantity: countQuantity, parentSku: sku);
                }else if(type == "SimpleProduct"){
                  await value.addToCart(sku: sku, quantity: countQuantity);  
                }
              },
              child: ButtonSecondary(
                text: 'Thêm vào giỏ hàng', 
                isLoading: value.getStatusSubmit 
              ),
            );
          }),
        ],
      ),
    );
  }

  SizedBox ButtonIncrement() {
    return SizedBox(
      width: 30,
      height: 30,
      child: FloatingActionButton(
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        hoverColor: colorBorder,
        backgroundColor: colorWhite,
        focusColor: colorBorder,
        onPressed: () {
          setState(() {
            countQuantity++;
          });
        },
        child: const Icon(Icons.add, color: colorBlack, size: 18),
      ),
    );
  }

  SizedBox ButtonDecrement() {
    return SizedBox(
      width: 30,
      height: 30,
      child: FloatingActionButton(
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        hoverColor: colorBorder,
        backgroundColor: colorWhite,
        focusColor: colorBorder,
        onPressed: () {
          if(countQuantity.toInt() == 1){
            return;
          }
    
          setState(() {
            countQuantity--;
          });
        },
        child: const Icon(Icons.remove, color: colorBlack, size: 18),
      ),
    );
  }
}





