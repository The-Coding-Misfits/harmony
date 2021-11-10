import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harmony/models/place.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:harmony/widgets/general_use/rating_widget.dart';
import 'package:harmony/widgets/login_register/harmony_shiny_button.dart';
import 'package:latlong2/latlong.dart';

class SpotInfo extends StatefulWidget {

  const SpotInfo({Key? key}) : super(key: key);

  @override
  SpotInfoState createState() => SpotInfoState();
}

class SpotInfoState extends State<SpotInfo> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    Place place = args["place"] as Place;
    double distance = args["distance"];
    String imageUrl = args["imageUrl"];

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Spot Details", style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0x11000000),
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: SizedBox(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(place.point.latitude, place.point.longitude),
                  zoom: 15.0,
                ),
                layers: [
                  TileLayerOptions(
                      urlTemplate: "https://api.mapbox.com/styles/v1/emirsurmen/ckvnyv8r5dhwz14nnxz6oqfbk/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZW1pcnN1cm1lbiIsImEiOiJja3Zudnc0bWUwODhjMzFrZ2g4c3FhdXh6In0.hj6d-tS9kiDepCIjqJOG5A",
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
                          point: LatLng(place.point.latitude, place.point.longitude),
                          builder: (ctx) => const Icon(FontAwesomeIcons.dotCircle, color: Colors.red, size: 30,)
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                place.name,
                style: const TextStyle(
                    fontSize: 20
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 5, left: 10, top: 5),
                child: Row(
                  children: [
                    RatingWidget(place.rating),
                    Text(" ${place.rating}/5.0 • ${distance}KM Nearby",
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xff6a6a6a),
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ],
                )
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.network(imageUrl, scale: 6)
              )
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Align(
                  alignment: Alignment.center,
                  child: HarmonyShinyButton(
                    "Get directions",
                    () {
                      MapsLauncher.launchCoordinates(place.point.latitude, place.point.longitude);
                    },
                    size: 50,
                  )
              )
          )
        ],
      ),
    );
  }
}