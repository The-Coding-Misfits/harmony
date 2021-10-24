import 'package:flutter/material.dart';
import 'package:harmony/services/kdtree_service.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/views/discover/filter/filter_sheet.dart';
import 'package:harmony/widgets/general_use/HarmonyBottomNavigationBar.dart';
import 'package:harmony/widgets/general_use/clickable_text.dart';

class DiscoverPage extends StatefulWidget {
  static bool initTree = false;

  DiscoverPage({Key? key}) : super(key: key) {
    if (!initTree) {
      KDTreeService.initTree();
      initTree = true;
    }
  }

  @override
  DiscoverPageState createState() => DiscoverPageState();
}


class DiscoverPageState extends State<DiscoverPage> {
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
      onPressed: (){},
      icon: Icon(
          Icons.menu,
        size: 25,
      ),
    );

    filterButton = IconButton( //filter button
      onPressed: _toFilterScreen,
      icon: Icon(
          Icons.sort,
        size: 25,
      ),
    );
    discoverText = Text(
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
      textWidget: Text(
        "Cancel",
        style: TextStyle(color : Colors.black45),
      ),
    );
    filtersText = Text(
        "Filters"
    );
    saveText = ClickableText(
      onPress: (){},
      textWidget: Text(
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
                  return Container();
                },
              ),
            ),
          ]
        ),
      ),
      bottomNavigationBar: HarmonyBottomNavigationBar(),
    );
  }

  void _toFilterScreen(){
    showModalBottomSheet(
        context: context,
        builder: (context) => FilterSheet(context),
    ).whenComplete(() => null);
  }
}
