import 'package:flutter/material.dart';
import 'package:harmony/services/kdtree_service.dart';
import 'package:harmony/widgets/general_use/clickable_text.dart';

class DiscoverPage extends StatefulWidget {
  static bool initTree = false;
  DiscoverPage(){
    if (!initTree){
      KDTreeService.initTree();
      initTree = true;
    }

  }

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {

  //App bar variables, if filter modal sheet is closed then discover widgets otherwise filter widgets
  ///DISCOVER WIDGETS
  IconButton hamburgerButton = IconButton(
    onPressed: onPressed,
    icon: Icon(Icons.menu),
  );
  Text discoverText = Text(
    "Discover",
  );
  IconButton filterButton = IconButton( //filter button
    onPressed: ,
    icon: Icon(
        Icons.sort
    ),
  );

  ///FILTER WIDGETS
  ClickableText cancelText = ClickableText(
    onPress: ,
    textWidget: Text(
      "Cancel",
      style: TextStyle(color : Colors.black45),
    ),
  );
  Text filtersText = Text(
    "Filters"
  );
  ClickableText saveText = ClickableText(
    onPress: ,
    textWidget: Text(
      "Save",
      style: TextStyle(color: Colors.greenAccent),
    ),
  );

  //Will change these variables in future to change appbar look
  Widget appBarLeftWidget;
  Wiget appBarRightWidget;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //stupid go back button
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [



            ],
          )
        ],
      ),
      body: SafeArea(

      ),
    );
  }

  void filterScreen(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (context) => ,

    );
  }
}
