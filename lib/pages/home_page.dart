import 'package:bbb/variables/color.dart';
import 'package:bbb/widgets/appbar.dart';
import 'package:bbb/widgets/menu_sidebar.dart';
import 'package:bbb/widgets/sticky_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      bottomSheet: Container(
        color: Colors.transparent,
        height: 80,
        child: StickyFooter(scaffoldKey: _scaffoldKey)
      )
    );
  }
}
