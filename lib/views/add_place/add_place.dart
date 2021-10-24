import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';
import 'package:harmony/widgets/filter/category_widgets/category_grid.dart';
import 'package:harmony/widgets/general_use/harmony_bottom_navigation_bar.dart';
import 'package:harmony/widgets/login_register/harmony_shiny_button.dart';
import 'package:image_picker/image_picker.dart';

class AddPlace extends StatefulWidget {
  final CategoryGrid _categoryGrid = CategoryGrid();


  PlaceCategory? get selectedCategory => _categoryGrid.selectedCategory;

  @override
  AddPlaceState createState() => AddPlaceState();
}

class AddPlaceState extends State<AddPlace> {

  TextEditingController nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Add new spot", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        // actions: [
        //   TextButton(
        //     onPressed: () {
        //
        //     },
        //     child: const Text("Save", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        //     style: ButtonStyle(
        //       foregroundColor: MaterialStateProperty.all(Colors.black),
        //       backgroundColor: MaterialStateProperty.all(Colors.transparent)
        //     ),
        //   )
        // ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextField(
                  style: const TextStyle(fontSize: 24),
                  decoration: const InputDecoration.collapsed(
                    hintStyle: TextStyle(fontSize: 24),
                    hintText: 'Give it a name...',
                  ),
                  controller: nameController,
                ),
              ),
              const Text("What can you do here?", style: TextStyle(fontSize: 18)),
              SizedBox(
                height: 50,
                width: 500,
                child: widget._categoryGrid,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: GestureDetector(
                  onTap: () async {
                    final List<XFile>? images = await _picker.pickMultiImage();
                  },
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    color: const Color(0xffececec),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.camera_alt_outlined, color: Color(0xff8d8d8d)),
                        Text("ADD COVER PHOTO", style: TextStyle(color: Color(0xff8d8d8d), fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
              ),

              // Save Button
              HarmonyShinyButton(
                "ADD NEW SPOT",
                () { // onPress

                },
                size: 50,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const HarmonyBottomNavigationBar(),
    );
  }
}