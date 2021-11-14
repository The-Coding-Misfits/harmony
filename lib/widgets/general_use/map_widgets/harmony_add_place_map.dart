import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:harmony/widgets/general_use/map_widgets/map_constants.dart';
import 'package:latlong2/latlong.dart';

import 'markers.dart';

class HarmonyAddPlaceMap extends StatefulWidget {
  final double latitude;
  final double longitude;

  const HarmonyAddPlaceMap({Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  HarmonyAddPlaceMapState createState() => HarmonyAddPlaceMapState();
}

class HarmonyAddPlaceMapState extends State<HarmonyAddPlaceMap> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(

      options: MapOptions(
        center: LatLng(widget.latitude, widget.longitude),
        zoom: 15.0,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: kUrlTemplate ,
            additionalOptions: kMapAdditionalInfo
        ),
        Markers().getAddPlacePageMarker(LatLng(widget.latitude, widget.longitude))
      ],
    );
  }
}