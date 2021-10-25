import 'package:flutter/material.dart';
import 'package:harmony/services/kdtree_service.dart';
import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/viewmodel/discover/discover_page_viewmodel.dart';
import 'package:harmony/views/discover/filter/filter_sheet.dart';
import 'package:harmony/views/mixin/uses_sidebar_mixin.dart';
import 'package:harmony/widgets/general_use/harmony_bottom_navigation_bar.dart';
import 'package:harmony/widgets/general_use/clickable_text.dart';
import 'package:harmony/widgets/side_bar/side_bar.dart';

class DiscoverPage extends StatefulWidget {
  static bool initTree = false;

  final DiscoverPageViewModel _discoverPageViewModel = DiscoverPageViewModel();

  DiscoverPage({Key? key}) : super(key: key) {
    if (!initTree) {
      KDTreeService.initTree();
      initTree = true;
    }
  }

  @override
  DiscoverPageState createState() => DiscoverPageState();
}


class DiscoverPageState extends State<DiscoverPage> with UsesSideBar {
  //Late in all vars because i hate the framework decision of not being able to initialize in constructors!


  ///DISCOVER WIDGETS
  IconButton? hamburgerButton;
  late Text discoverText;
  late IconButton filterButton;
  DiscoverPageState(){
    //Init variables
    _initDiscoverWidgets();
  }

  void _initDiscoverWidgets(){
    ///DISCOVER WIDGETS
    hamburgerButton = null; // WILL BE ASSIGNED WHEN MENU CALLBACK AVAILABLE

    filterButton = IconButton( //filter button
      onPressed: _toFilterScreen,
      icon: const Icon(
          Icons.sort,
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SideBar(
        menuCallback: menuCallback,
        child: SafeArea(
          child: Column(
            children: [
              ///TOP BAR
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    hamburgerButton ?? const SizedBox(), // if null currently
                    discoverText,
                    filterButton
                  ],
                ),
              ),
              ///Show actual places
              Expanded(
                flex: 9,
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index){
                    return Container();
                  },
                ),
              ),
            ]
          ),
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
          widget._discoverPageViewModel
        ),
    ).whenComplete(() => null);
  }

  void menuCallback(Function() onPress){
    setState(() {
      hamburgerButton = onMenuCallback(onPress);
    });
  }
}
