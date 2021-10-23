import 'package:flutter/material.dart';

class AddPlace extends StatefulWidget {
  const AddPlace({Key? key}) : super(key: key);

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
        backgroundColor: const Color(0xff00CA9D),
        actions: [
          TextButton(
            onPressed: () {

            },
            child: const Text("Save"),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(Colors.transparent)
            ),
          )
        ],
      ),
    );
  }
}