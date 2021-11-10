import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harmony/models/place.dart';
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
          Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset("assets/images/dummy-national-park.jpg", scale: 6)
              )
          )
        ],
      ),
    );
  }
}