import 'package:flutter/material.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';
import 'package:harmony/widgets/filter/category_widgets/category_grid.dart';
import 'package:harmony/widgets/general_use/harmony_bottom_navigation_bar.dart';

class AddPlace extends StatefulWidget {
  final CategoryGrid _categoryGrid = CategoryGrid();


  PlaceCategory? get selectedCategory => _categoryGrid.selectedCategory;

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
            Expanded(
              flex: 1,
                child: widget._categoryGrid
            ),
          ],
        ),
      ),
      bottomNavigationBar: const HarmonyBottomNavigationBar(),
    );
  }
}