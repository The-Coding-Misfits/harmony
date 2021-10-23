import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harmony/utilites/gridviewitem.dart';

class AddPlace extends StatefulWidget {
  const AddPlace({Key? key}) : super(key: key);

  @override
  AddPlaceState createState() => AddPlaceState();
}

class AddPlaceState extends State<AddPlace> {
  int optionSelected = 0;

  void checkOption(int index) {
    setState(() {
      optionSelected = index;
    });
  }

  List items = [
    const Icon(Icons.backpack),
    const FaIcon(FontAwesomeIcons.bicycle),
    const FaIcon(FontAwesomeIcons.swimmer),
    const FaIcon(FontAwesomeIcons.running),
    const FaIcon(FontAwesomeIcons.campground),
    const FaIcon(FontAwesomeIcons.paw)
  ];

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
            child: const Text("Save", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(Colors.transparent)
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 5, left: 5),
                child: Text("What can you do here?", style: TextStyle(fontSize: 18)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: GridView.count(
                crossAxisCount: 6,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                shrinkWrap: true,
                children: [
                  for (int i = 0; i < items.length; i++) GridViewItem(
                      icon: items[i],
                      selected: i + 1 == optionSelected,
                      onTap: () => checkOption(i + 1)
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}