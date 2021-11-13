import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

import 'map_constants.dart';
import 'markers.dart';

class HarmonyNearbyMap extends StatefulWidget {
  final double latitude;
  final double longitude;
  const HarmonyNearbyMap({required this.latitude, required this.longitude});

  @override
  _HarmonyNearbyMapState createState() => _HarmonyNearbyMapState();
}

class _HarmonyNearbyMapState extends State<HarmonyNearbyMap> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(widget.latitude, widget.longitude),
        zoom: 15.0,
        plugins: [
          const LocationMarkerPlugin()
        ]
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: kUrlTemplate ,
            additionalOptions: kMapAdditionalInfo
        ),
        Markers().getNearbyPageMarker()
      ],
    );
  }
}
