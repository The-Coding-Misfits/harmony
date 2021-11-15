import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/services/location_service.dart';
import 'package:harmony/utilites/custom_exception.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';
import 'package:harmony/viewmodel/add_place/add_place_viewmodel.dart';
import 'package:harmony/widgets/filter/category_widgets/category_grid.dart';
import 'package:harmony/widgets/general_use/map_widgets/harmony_add_place_map.dart';
import 'package:harmony/widgets/login_register/harmony_shiny_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class AddPlace extends StatefulWidget {
  final AddPlaceViewModel _viewModel = AddPlaceViewModel();

  AddPlace({Key? key}) : super(key: key);

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
  final LocationService locationService = LocationService();
  LocationData? locationData;

  PlaceCategory? categorySelected;

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      setState(() {
        canAdd = isEligibleAdd();
      });
    }); // listen for change and change eligible
  }

  @override
  Widget build(BuildContext context) {
    Widget mapWidget = FutureBuilder(
      future: locationService.getLocation(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: const Color(0xffececec),
            child: const Align(
              alignment: Alignment.center,
              child: Text("Loading map..."),
            ),
          );
        }

        // if get location throws an error, why would it though...
        if (snapshot.hasError) {
          return Container(
            color: const Color(0xffececec),
            child: const Align(
              alignment: Alignment.center,
              child: Text("Error loading map and getting location!"),
            ),
          );
        }

        LocationData data = snapshot.data;
        locationData = data;

        return HarmonyAddPlaceMap(
          latitude: data.latitude!,
          longitude: data.longitude!,
        );
      },
    );


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Add new spot", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Center(
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
                    child: CategoryGrid(
                        updateSelectedCategory,
                       [],//we dont want staring value
                      isSingleOptionOnly: true,
                    ),
                    onTap: (){canAdd = isEligibleAdd();},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: mapWidget
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: GestureDetector(
                    onTap: () async {
                      XFile? pickedImage;

                      showModalBottomSheet(
                          context: context,
                          builder: (context) => SafeArea(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.camera_alt),
                                    title: const Text("Take photo with Camera"),
                                    onTap: () async {
                                      pickedImage = await _picker.pickImage(source: ImageSource.camera);

                                      var bytes = await pickedImage!.readAsBytes();

                                      setState(() {
                                        selectedImage = File(pickedImage!.path);
                                        canAdd = isEligibleAdd();
                                        imageUploaded = true;
                                        imageBytes = bytes;
                                      });

                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.image),
                                    title: const Text("Select from gallery"),
                                    onTap: () async {
                                      pickedImage = await _picker.pickImage(source: ImageSource.gallery);

                                      var bytes = await pickedImage!.readAsBytes();

                                      setState(() {
                                        selectedImage = File(pickedImage!.path);
                                        canAdd = isEligibleAdd();
                                        imageUploaded = true;
                                        imageBytes = bytes;
                                      });

                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              )
                          )
                      );
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
      ),
    );
  }


  void updateSelectedCategory(List<PlaceCategory> selectedCategoryFromGrid){
    setState(() {
      categorySelected = selectedCategoryFromGrid.isEmpty ? null : selectedCategoryFromGrid.first; //its actually a list with one element
    });
  }

  void addPlace() {
    if (isEligibleAdd()) {
      handleAdding();
    }
  }

  void handleAdding() async{
    showSnackbar("Adding place...");
    try{
      Place place = await createPlace();
      showSnackbar("Added spot!");
    }
    on CustomException catch(_){
      showSnackbar("Adding failed because ${_.cause}");
    }
    on Exception catch(_){
      print(_.toString());
      showSnackbar("An error happened while adding the place!");
    }
  }

  Future<Place> createPlace() async{



    Place createdPlace = await createPlaceModel();
  }

  Future<Place> createPlaceModel(){
    return widget._viewModel.createPlace(
      nameController.value.text,
      categorySelected!,
      selectedImage!,

      // location
      locationData!.latitude!.toDouble(),
      locationData!.longitude!.toDouble(),
    );
  }

  void showSnackbar(String message){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))
    );
  }


  bool isEligibleAdd() {
    return (selectedImage != null && nameController.value.text.isNotEmpty && categorySelected != null && locationData != null);
  }
}