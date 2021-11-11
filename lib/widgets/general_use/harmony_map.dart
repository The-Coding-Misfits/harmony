import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';

class HarmonyMap extends StatefulWidget {
  final double latitude;
  final double longitude;

  const HarmonyMap({Key? key,
    required this.latitude,
    required this.longitude}) : super(key: key);

  @override
  HarmonyMapState createState() => HarmonyMapState();
}

class HarmonyMapState extends State<HarmonyMap> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(widget.latitude, widget.longitude),
        zoom: 15.0,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://api.mapbox.com/styles/v1/emirsurmen/ckvsfi26s0zzx14p8iqed9zw4/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZW1pcnN1cm1lbiIsImEiOiJja3Zudnc0bWUwODhjMzFrZ2g4c3FhdXh6In0.hj6d-tS9kiDepCIjqJOG5A",
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
                point: LatLng(widget.latitude, widget.longitude),
                builder: (ctx) =>
                const Icon(FontAwesomeIcons.dotCircle, color: Colors.red, size: 30,)
            ),
          ],
        ),
      ],
    );
  }
}