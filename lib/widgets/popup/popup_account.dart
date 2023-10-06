// ignore_for_file: non_constant_identifier_names

import 'package:bbb/variables/color.dart';
import 'package:bbb/widgets/popup/account/popup_login.dart';
import 'package:bbb/widgets/popup/account/popup_register.dart';
import 'package:flutter/material.dart';

class PopupAccount extends StatefulWidget {
  const PopupAccount({super.key});

  @override
  State<PopupAccount> createState() => _PopupAccountState();
}

class _PopupAccountState extends State<PopupAccount> with SingleTickerProviderStateMixin {
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

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colorWhite,
      child: Column(
        children: [
          Container(
            height: 32,
            margin: const EdgeInsets.only(bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PopupAccountTabBar(),
                // SvgPicture.asset("assets/images/icon/icon-close.svg")
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                PopupLogin(emailController: emailController, passwordController: passwordController),
                PopupRegister(emailController: emailController, passwordController: passwordController, firstNameController: firstNameController, lastNameController: lastNameController,)
              ],
            ),
          ),
        ]
      ),
    );
  }

  TabBar PopupAccountTabBar() {
    return TabBar(
      labelPadding: const EdgeInsets.all(0),
      isScrollable: true,
      controller: _tabController,
      indicator: const BoxDecoration(
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
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: index == 0 ? colorTheme : colorBorder,
            ),
            child: const Text("Đăng nhập", style: TextStyle(fontWeight: FontWeight.w600))
          )
        ),
        Tab(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: index == 1 ? colorTheme : colorBorder,
            ),
            child: const Text("Đăng ký", style: TextStyle(fontWeight: FontWeight.w600))
          )
        ),
      ],
    );
  }
}

