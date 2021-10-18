import 'package:flutter/material.dart';
import 'package:harmony/services/kdtree_service.dart';

import 'starting_page.dart';

void main() {
  KDTreeService.initTree();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harmony',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Montserrat",
        primaryColor: const Color(0xff00CA9D)
      ),
      home: const StartingPage(),
    );
  }
}
