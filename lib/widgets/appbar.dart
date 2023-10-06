import 'package:bbb/variables/color.dart';
import 'package:bbb/widgets/appbar/appbar_actions.dart';
import 'package:bbb/widgets/appbar/appbar_leading.dart';
import 'package:bbb/widgets/appbar/appbar_title.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: colorTheme,
      titleSpacing: 20,
      leadingWidth: 55,
      elevation: 0 ,
      leading: const AppBarLeading(),
      title: const AppBarTitle(),
      actions: const [
        AppBarActions()
      ]
    );
  }
}








