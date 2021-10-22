import 'package:flutter/material.dart';

class AddPlace extends StatefulWidget {
  @override
  AddPlaceState createState() => AddPlaceState();
}

class AddPlaceState extends State<AddPlace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add new spot"),
        actions: [
          TextButton(
            onPressed: () {

            },
            child: const Text("Save"),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(const Color(0xff00CA9D)),
              backgroundColor: MaterialStateProperty.all(Colors.transparent)
            ),
          )
        ],
      ),
    );
  }
}