import 'package:flutter/material.dart';
import 'package:harmony/services/kdtree_service.dart';
import 'package:harmony/utilites/constants.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {

          },
        ),
        title: const Text("Discover"),
        backgroundColor: const Color(0xff00CA9D),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                kAddPlacePageRouteName
              );
            },
            icon: const Icon(Icons.add_box_outlined)
          )
        ],
      ),
    );
  }
}
