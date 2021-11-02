import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';
import 'package:harmony/viewmodel/add_place/add_place_viewmodel.dart';
import 'package:harmony/widgets/filter/category_widgets/category_grid.dart';
import 'package:harmony/widgets/general_use/harmony_bottom_navigation_bar.dart';
import 'package:harmony/widgets/login_register/harmony_shiny_button.dart';
import 'package:image_picker/image_picker.dart';

class AddPlace extends StatefulWidget {
  final CategoryGrid _categoryGrid = CategoryGrid();
  final AddPlaceViewModel _viewModel = AddPlaceViewModel();

  AddPlace({Key? key}) : super(key: key);

  PlaceCategory? get selectedCategory => _categoryGrid.selectedCategory;

  @override
  AddPlaceState createState() => AddPlaceState();
}

class AddPlaceState extends State<AddPlace> {

  TextEditingController nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  bool canAdd = false;
  bool imageUploaded = false;
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {setState(() {
      canAdd = isEligibleAdd();
    });}); // listen for change and change eligible
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                child: GestureDetector( //Re evaulate can add when touched category grid
                    child: widget._categoryGrid,
                  onTap: (){canAdd = isEligibleAdd();},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: GestureDetector(
                  onTap: () async {
                    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

                    var bytes = await pickedImage!.readAsBytes();

                    setState(() {
                      selectedImage = File(pickedImage.path);
                      canAdd = isEligibleAdd();
                      imageUploaded = true;
                      imageBytes = bytes;
                    });
                  },
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    color: const Color(0xffececec),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: imageUploaded ? false : true,
                          child: const Icon(Icons.camera_alt_outlined, color: Color(0xff8d8d8d)),
                        ),
                        Visibility(
                          visible: imageUploaded ? false : true,
                          child: const Text("ADD COVER PHOTO", style: TextStyle(color: Color(0xff8d8d8d), fontWeight: FontWeight.bold)),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 180
                          ),
                          child: imageUploaded ? Image.memory(imageBytes!) : const SizedBox(width: 0, height: 0),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              // Save Button
              HarmonyShinyButton(
                "ADD NEW SPOT",

                addPlace,
                isActive: canAdd, //is active
                size: 50,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: HarmonyBottomNavigationBar(
        PAGE_ENUM.NEARBY_PAGE
      ),
    );
  }
  void addPlace(){
    if(isEligibleAdd()){
      widget._viewModel.createPlace(
        nameController.value.text,
        widget._categoryGrid.categoryGridController.selectedCategory!,
        selectedImage!,
        getCoordinates()

      );
    }
  }

  bool isEligibleAdd(){
    return (selectedImage != null && nameController.value.text.isNotEmpty && widget._categoryGrid.categoryGridController.selectedCategory != null);
  }

  List<double> getCoordinates(){
    return [
      math.Random().nextInt(10000).toDouble(),
      math.Random().nextInt(10000).toDouble(),
      math.Random().nextInt(10000).toDouble(),
    ];
  }
}