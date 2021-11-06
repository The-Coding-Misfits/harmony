import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harmony/services/location_service.dart';
import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';
import 'package:harmony/viewmodel/add_place/add_place_viewmodel.dart';
import 'package:harmony/widgets/filter/category_widgets/category_grid.dart';
import 'package:harmony/widgets/general_use/harmony_bottom_navigation_bar.dart';
import 'package:harmony/widgets/login_register/harmony_shiny_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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

  final LocationService locationService = LocationService();
  LocationData? locationData;

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

        return FlutterMap(
          options: MapOptions(
            center: LatLng(data.latitude!.toDouble(), data.longitude!.toDouble()),
            zoom: 13.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://api.mapbox.com/styles/v1/emirsurmen/ckvnw0v1m4hua14pigfs0c0k0/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZW1pcnN1cm1lbiIsImEiOiJja3Zudnc0bWUwODhjMzFrZ2g4c3FhdXh6In0.hj6d-tS9kiDepCIjqJOG5A",
              additionalOptions: {
                "accessToken": "pk.eyJ1IjoiZW1pcnN1cm1lbiIsImEiOiJja3Zudnk1MTcxYmtlMzJrbDdncWp2YXZvIn0.cU2tnWQoUKHWZGYevlnb6w",
                "id": "mapbox.satellite"
              }
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(data.latitude!.toDouble(), data.longitude!.toDouble()),
                  builder: (ctx) =>
                      const Icon(FontAwesomeIcons.mapMarkerAlt, color: Colors.red, size: 30,)
                ),
              ],
            ),
          ],
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
                    child: widget._categoryGrid,
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
      bottomNavigationBar: HarmonyBottomNavigationBar(
        PAGE_ENUM.NEARBY_PAGE
      ),
    );
  }
  void addPlace() {

    if (isEligibleAdd()) {
      var createPlace = widget._viewModel.createPlace(
        nameController.value.text,
        widget._categoryGrid.categoryGridController.selectedCategory!,
        selectedImage!,

        // location
        locationData!.latitude!.toDouble(),
        locationData!.longitude!.toDouble(),
      );

      if (createPlace == 500) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Error while adding place!"))
        );
      }
    }
  }

  bool isEligibleAdd() {
    return (selectedImage != null && nameController.value.text.isNotEmpty && widget._categoryGrid.categoryGridController.selectedCategory != null && locationData != null);
  }
}