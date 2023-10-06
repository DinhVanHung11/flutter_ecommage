import 'package:bbb/variables/color.dart';
import 'package:bbb/widgets/menu/menu_category.dart';
import 'package:bbb/widgets/menu/topnav/tab_account.dart';
import 'package:bbb/widgets/menu/topnav/tab_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuSideBar extends StatefulWidget {
  const MenuSideBar({super.key});

  @override
  State<MenuSideBar> createState() => _MenuSideBarState();
}

class _MenuSideBarState extends State<MenuSideBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int index = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          height: 60, 
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: colorBorder))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: TabBar(
                  labelPadding: const EdgeInsets.all(0),
                  isScrollable: true,
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: colorTheme,
                  ),
                  labelColor: colorWhite,
                  unselectedLabelColor: colorBlack,
                  onTap: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  tabs: [
                    Tab(
                      child: TabCategorySideBar(index: index),
                    ),
                    Tab(
                      child: TabAccountSideBar(index: index),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Hero(
                  tag: "closemodalmenu",
                  child: SvgPicture.asset("assets/images/icon/icon-close.svg")
                )
              )
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              MenuCategory(),
              Center(
                child: Text(
                  'Buy Now',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]
    );
  }
}





