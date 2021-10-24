import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harmony/utilites/constants.dart';

class HarmonyBottomNavigationBar extends StatelessWidget {
  const HarmonyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Icon(FontAwesomeIcons.compass),
          onPressed: () => Navigator.pushReplacementNamed(context, kDiscoverPageRouteName),
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.globe),
          onPressed: () => Navigator.pushReplacementNamed(context, kAddPlacePageRouteName), //TODO NOT ADD PLACE TO NEARBY ACTULY
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.user),
          onPressed: () => null,//Navigator.pushReplacementNamed(context, routeName),
        )
      ],
    );
  }
}
