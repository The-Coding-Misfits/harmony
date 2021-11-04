import 'package:flutter/material.dart';

import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/viewmodel/discover/discover_page_viewmodel.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_sheet.dart';
import 'package:harmony/widgets/general_use/hamburger_button.dart';
import 'package:harmony/widgets/general_use/place_card.dart';
import 'package:harmony/widgets/general_use/harmony_bottom_navigation_bar.dart';
import 'package:harmony/services/auth_service.dart';

class DiscoverPage extends StatefulWidget {

  final DiscoverPageViewModel _discoverPageViewModel = DiscoverPageViewModel();

  DiscoverPage({Key? key}) : super(key: key);

  @override
  DiscoverPageState createState() => DiscoverPageState();
}


class DiscoverPageState extends State<DiscoverPage> {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            ///TOP BAR
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HamburgerButton(),
                //App bar title
                const Text(
                  "Discover",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                IconButton( //filter button
                  onPressed: _toFilterSheet,
                  icon: const Icon(
                    Icons.filter_alt_sharp,
                    size: 25,
                  ),
                )
                ],
              ),
            ),
            ///Show actual places
            Expanded(
              flex: 9,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index){
                  return const PlaceCard(
                    rating: 2.8,
                    imageUrl: "assets/images/dummy-national-park.jpg",
                    distance: 1.2
                  );
                },
              ),
            ),
          ]
        ),
      ),
      bottomNavigationBar: HarmonyBottomNavigationBar(
        PAGE_ENUM.DISCOVER_PAGE
      ),
    );
  }

  void _toFilterSheet() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 500),
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, _, __) {
        return FilterSheet();

      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ).drive(Tween<Offset>(
            begin: const Offset(0, -1.0),
            end: Offset.zero,
          )),
          child: child,
        );
      },
    );
  }
}
