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
          icon: const Icon(FontAwesomeIcons.compass),
          onPressed: () => Navigator.pushReplacementNamed(context, kDiscoverPageRouteName),
        ),
        IconButton(
          icon: const Icon(Icons.add_box_outlined),
          onPressed: () => Navigator.pushReplacementNamed(context, kAddPlacePageRouteName), //TODO NOT ADD PLACE TO NEARBY ACTULY
        ),
        IconButton(
          icon: const Icon(FontAwesomeIcons.user),
          onPressed: () {},//Navigator.pushReplacementNamed(context, routeName),
        )
      ],
    );
  }
}
