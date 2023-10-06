import 'package:bbb/variables/color.dart';
import 'package:bbb/widgets/popup/popup_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StickyFooter extends StatelessWidget {
  const StickyFooter({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 20,
              color: Colors.white,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              height: 60,
              decoration: const BoxDecoration(
                color: colorWhite,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    blurRadius: 10.0,
                    offset: Offset(0,-5),
                  )
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  InkWell(
                    onTap: (){
                    },
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SvgPicture.asset("assets/images/icon/icon-bill.svg"),
                      const SizedBox(height: 5),
                      const Text('Đơn mua', style: TextStyle(color: colorTheme, fontSize: 12))
                    ]),
                  ),
                  InkWell(
                    onTap: (){
                    },
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SvgPicture.asset("assets/images/icon/icon-system.svg"),
                      const SizedBox(height: 5),
                      const Text('Hệ thống', style: TextStyle(color: colorTheme, fontSize: 12))
                    ]),
                  ),
                  const SizedBox(
                    width: 60,
                    height: 80
                  ),
                  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SvgPicture.asset("assets/images/icon/icon-phone.svg"),
                    const SizedBox(height: 5),
                    const Text('Hotline', style: TextStyle(color: colorTheme, fontSize: 12))
                  ]),
                  InkWell(
                    onTap: () {
                      showDialog(context: context, 
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: colorWhite,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: const PopupAccount()
                            ),
                          );
                        },
                      );
                    },
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SvgPicture.asset("assets/images/icon/icon-account.svg"),
                      const SizedBox(height: 5),
                      const Text('Tài khoản', style: TextStyle(color: colorTheme, fontSize: 12))
                    ]),
                  ),
                ],
              ),
            ),
          ]),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: Container(
                    width: 68,
                    height: 65,
                    decoration: BoxDecoration(
                      color: const Color(0xffFCE4F0),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: SvgPicture.asset("assets/images/icon/icon-menu.svg", fit: BoxFit.cover)
                      ),
                      const SizedBox(height: 5),
                      const Text('Danh mục', style: TextStyle(fontWeight: FontWeight.w600, color: colorTheme, fontSize: 12)),
                    ],),
                  ),
                )
              ],
            ),
          )
        )
      ]
    );
  }
}

