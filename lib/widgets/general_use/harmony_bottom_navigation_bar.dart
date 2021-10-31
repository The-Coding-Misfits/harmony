import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/views/account/account_page.dart';
import 'package:harmony/views/add_place/add_place.dart';
import 'package:harmony/views/discover/discover_page.dart';

class HarmonyBottomNavigationBar extends StatelessWidget {
  final PAGE_ENUM currPage;
  final Color _activeColor = Color(0xff00CA9D);
  final Color _inactiveColor = Colors.black54;

  HarmonyBottomNavigationBar(this.currPage);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Icon(
            FontAwesomeIcons.compass,
            color: currPage == PAGE_ENUM.DISCOVER_PAGE ? _activeColor : _inactiveColor,

          ),
          onPressed: () =>  Navigator.pushReplacement(

            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => DiscoverPage(),
              transitionDuration: Duration(seconds: 1),
            ),
          ),
        ),
        IconButton(
            icon: Icon(
              Icons.add_box_outlined,
              color: currPage == PAGE_ENUM.NEARBY_PAGE ? _activeColor : _inactiveColor,
            ),
            onPressed: () =>  Navigator.pushReplacement(

              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => AddPlace(), //TODO ACTUALLY NEARBY!!!
                transitionDuration: Duration(seconds: 1),
              ),
            )
        ),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.user,
            color: currPage == PAGE_ENUM.ACCOUNT_PAGE ? _activeColor : _inactiveColor,
          ),
          onPressed: () =>  Navigator.pushReplacement(

            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => AccountPage(),
              transitionDuration: Duration(seconds: 1),
            ),
          ),//Navigator.pushReplacementNamed(context, routeName),
        )
      ],
    );
  }
}