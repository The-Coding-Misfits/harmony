import 'package:flutter/material.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/utilites/login_register_states/signout_state.dart';
import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/viewmodel/discover/discover_page_viewmodel.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_sheet.dart';
import 'package:harmony/widgets/general_use/place_card.dart';
import 'package:harmony/widgets/general_use/harmony_bottom_navigation_bar.dart';
import 'package:harmony/widgets/general_use/clickable_text.dart';
import 'package:harmony/services/auth_service.dart';

class DiscoverPage extends StatefulWidget {

  final DiscoverPageViewModel _discoverPageViewModel = DiscoverPageViewModel();

  DiscoverPage({Key? key}) : super(key: key);

  @override
  DiscoverPageState createState() => DiscoverPageState();
}


class DiscoverPageState extends State<DiscoverPage> {
  final AuthService authService = AuthService();

  //Late in all vars because i hate the framework decision of not being able to initialize in constructors!

  //Will change these variables in future to change appbar look
  late Widget appBarLeftWidget;
  late Text appBarTitle;
  late Widget appBarRightWidget;
  //App bar variables, if filter modal sheet is closed then discover widgets otherwise filter widgets
  ///DISCOVER WIDGETS
  late IconButton hamburgerButton;
  late Text discoverText;
  late IconButton filterButton;

  ///FILTER WIDGETS
  late ClickableText cancelText;
  late Text filtersText;
  late ClickableText saveText;

  DiscoverPageState(){
    //Init variables
    _initDiscoverWidgets();
    _initFilterWidgets();

    //Initially they are set to discover page vars
    appBarLeftWidget = hamburgerButton;
    appBarTitle = discoverText;
    appBarRightWidget = filterButton;
  }

  void _initDiscoverWidgets(){
    ///DISCOVER WIDGETS
    hamburgerButton = IconButton(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("Settings"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Log Out"),
                  onTap: () async {
                    SIGNOUT_STATE signOutState = await authService.signOutUser();

                    if (signOutState == SIGNOUT_STATE.SUCCESSFUL) {
                      Navigator.pushReplacementNamed(
                        context,
                        kLoginPageRouteName
                      );
                    } else if (signOutState == SIGNOUT_STATE.ERROR) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("An error occurred."))
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
      icon: const Icon(
          Icons.menu,
        size: 25,
      ),
    );

    filterButton = IconButton( //filter button
      onPressed: _toFilterScreen,
      icon: const Icon(
          Icons.filter_alt_sharp,
        size: 25,
      ),
    );
    discoverText = const Text(
      "Discover",
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }

  void _initFilterWidgets(){
    ///FILTER WIDGETS
    cancelText = ClickableText(
      onPress: (){},
      textWidget: const Text(
        "Cancel",
        style: TextStyle(color : Colors.black45),
      ),
    );
    filtersText = const Text(
        "Filters"
    );
    saveText = ClickableText(
      onPress: (){},
      textWidget: const Text(
        "Save",
        style: TextStyle(color: Colors.greenAccent),
      ),
    );
  }

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
                  appBarLeftWidget,
                  appBarTitle,
                  appBarRightWidget
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

  void _toFilterScreen(){
    showModalBottomSheet(
        context: context,
        builder: (context) => FilterSheet(
            context,
        ),
    ).whenComplete(() => null);
  }
}
