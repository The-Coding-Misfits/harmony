import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harmony/services/auth_service.dart';
import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/views/account/account_page.dart';
import 'package:harmony/views/place/add_place.dart';
import 'package:harmony/views/discover/discover_page.dart';
import 'package:harmony/views/place/near_place.dart';

class HarmonyBottomNavigationBar extends StatelessWidget {
  final PAGE_ENUM currPage;
  final Color _activeColor = const Color(0xff00CA9D);
  final Color _inactiveColor = Colors.black54;

  HarmonyBottomNavigationBar(this.currPage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Divider(height: 1, thickness: 1),
          Row(
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
                    transitionDuration: const Duration(seconds: 1),
                  ),
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.near_me_outlined,
                    size: 26,
                    color: currPage == PAGE_ENUM.NEARBY_PAGE ? _activeColor : _inactiveColor,
                  ),
                  onPressed: () =>  Navigator.pushReplacement(

                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => const NearbyPage(), //TODO ACTUALLY NEARBY!!!
                      transitionDuration: const Duration(seconds: 1),
                    ),
                  )
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.user,
                  size: 22,
                  color: currPage == PAGE_ENUM.ACCOUNT_PAGE ? _activeColor : _inactiveColor,
                ),
                onPressed: () =>  Navigator.pushReplacement(

                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => AccountPage(AuthService.currHarmonyUser!),
                    transitionDuration: const Duration(seconds: 1),
                  ),
                ),//Navigator.pushReplacementNamed(context, routeName),
              )
            ],
          ),
        ],
      )
    );
  }
}