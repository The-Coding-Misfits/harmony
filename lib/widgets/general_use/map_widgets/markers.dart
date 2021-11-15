import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/widgets/general_use/add_place_marker.dart';
import 'package:latlong2/latlong.dart';

class Markers {
  final Color locationMarkerCircleColor = const Color(0xFFF5A623);

  MarkerLayerWidget getNearbyPageMarker(LatLng point) {
    return MarkerLayerWidget(
      options: MarkerLayerOptions(
          markers: [
            Marker(
              point: point,
              builder: (BuildContext context) {
                return DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: locationMarkerCircleColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.navigation,
                          size: 15,
                          color: Colors.white,
                        )
                    ),
                  ),
                );
              },
            ),
          ]
      ),
    );
  }

  MarkerLayerOptions getAddPlacePageMarker(LatLng point) {
    double lat = point.latitude;
    double lon = point.longitude;
    return MarkerLayerOptions(
      markers: [
        Marker(
          point: point,
          builder: (BuildContext context) {
            return DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: kHarmonyColor,
                    shape: BoxShape.circle,
                  ),
                  child: Hero(
                    tag : getSpotMarker(lat, lon),
                    child: const AddPlaceMarker(
                        20,
                        30,
                        15
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ]
    );
  }

  Marker getPlaceMarker(Place place){
    double lat = place.point.latitude;
    double lon = place.point.longitude;
    return Marker(
      point: LatLng(lat,lon),
        builder: (BuildContext context) {
          return Hero(
            tag: getSpotMarker(lat, lon),
            child: const Icon(
              Icons.location_on,
              size: 40
            ),
          );
        }
    );
  }


  String getSpotMarker(double latitude, double longitude){
    return "spot_marker_tag_lat${latitude}_lon$longitude";
  }
}