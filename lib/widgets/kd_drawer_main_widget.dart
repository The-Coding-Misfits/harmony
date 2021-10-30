import 'package:flutter/material.dart';

import 'package:harmony/views/account/account_page.dart';
import 'package:harmony/views/add_place/add_place.dart';
import 'package:harmony/views/discover/discover_page.dart';
import 'package:kf_drawer/kf_drawer.dart';

class MainWidget extends StatefulWidget {
  final KFDrawerContent initialPage;

  @override
  _MainWidgetState createState() => _MainWidgetState();

  const MainWidget(this.initialPage);
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  late KFDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: widget.initialPage,
      items: [
        KFDrawerItem.initWithPage(
          text: Text('Discover', style: const TextStyle(color: Colors.white)),
          icon: const Icon(Icons.home, color: Colors.white),
          page: DiscoverPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'CALENDAR',
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(Icons.calendar_today, color: Colors.white),
          page: AddPlace(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'SETTINGS',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.settings, color: Colors.white),
          page: AccountPage(),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KFDrawer(
//        borderRadius: 0.0,
//        shadowBorderRadius: 0.0,
//        menuPadding: EdgeInsets.all(0.0),
//        scrollable: true,
        controller: _drawerController,
        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width * 0.6,
            child: Image.asset(
              'assets/images/harmony.png',
              alignment: Alignment.centerLeft,
            ),
          ),
        ),
        footer: KFDrawerItem(
          text: Text(
            'SIGN IN',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.input,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(

              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => DiscoverPage(),
                transitionDuration: Duration(seconds: 1),
              ),
            );
          },
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromRGBO(255, 255, 255, 1.0), Color.fromRGBO(44, 72, 171, 1.0)],
            tileMode: TileMode.repeated,
          ),
        ),
      ),
    );
  }
}