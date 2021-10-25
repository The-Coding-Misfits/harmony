import 'package:flutter/material.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/utilites/kf_drawer/kf_drawer.dart';

///So this is kinda confusing, this class is can also be used for routing however it uses class names for that



class SideBar extends StatefulWidget {


  final Widget child;



  @override
  _SideBarState createState() => _SideBarState();

  SideBar({required this.child});
}

class _SideBarState extends State<SideBar> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
        if(discoverItem.onMenuPressed != null){
          print("Hurray");
        } else{
          print("FUCK");
        }
    });
  }

  final KFDrawerItem discoverItem = KFDrawerItem( // IGNORE, FOR HACKING PURPOSES
    text: Text("Discover"),
    icon: Icon(Icons.update),
  );

  @override
  Widget build(BuildContext context) {
    ///DESIGN IS FOR YOU, JUST OUTLINING THE STRUCTURE FOR YOU
    return KFDrawer(

      header: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          width: MediaQuery.of(context).size.width * 0.6,
          child: Container(),
        ),
      ),
      footer: KFDrawerItem(
        text: Text(
          'SIGN OUT'
        ),
        icon: Icon(Icons.update),
        onPressed: (){},
      ),
      items: [
        discoverItem
      ],
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [kHarmonyColor, Color.fromRGBO(199, 224, 205, 1.0)]
        )
      ), child: widget.child,
    );
  }
}
