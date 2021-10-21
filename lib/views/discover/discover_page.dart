import 'package:flutter/material.dart';
import 'package:harmony/services/kdtree_service.dart';

class DiscoverPage extends StatelessWidget {
  static bool initTree = false;
  DiscoverPage(){
    if (!initTree){
      KDTreeService.initTree();
      initTree = true;
    }

  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
