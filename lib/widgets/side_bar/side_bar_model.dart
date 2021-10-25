import 'package:harmony/utilites/kf_drawer/kf_drawer.dart';

class SideBarModel{



  KFDrawerItem item; // get the item so that we can reach on menu press later

  Function()? get onPress => item.onMenuPressed;

  SideBarModel(this.item);
}