import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/widgets/general_use/add_place_marker.dart';
import 'package:latlong2/latlong.dart';

class Markers {
  final Color locationMarkerCircleColor = const Color(0xFFF5A623);

  LocationMarkerLayerOptions getNearbyPageMarker(){
    return LocationMarkerLayerOptions(
        marker: DefaultLocationMarker(
          color: locationMarkerCircleColor,
          child: const Icon(
            Icons.navigation,
            color: Colors.white,
            size: 15,
          ),
        ),
        markerSize: const Size(25, 25),
        accuracyCircleColor: locationMarkerCircleColor.withOpacity(0.4),
        headingSectorColor: Colors.transparent,
        headingSectorRadius: 0,
        markerAnimationDuration: Duration.zero, // disable animation
      );
  }

  MarkerLayerOptions getAddPlacePageMarker(LatLng point) {
    return MarkerLayerOptions(
      markers: [
        Marker(
          point: point,
          builder: (BuildContext context) {
            return const DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(2),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: kHarmonyColor,
                    shape: BoxShape.circle,
                  ),
                  child: Hero(
                    tag : AddPlaceMarker.markerTag,
                    child: AddPlaceMarker(
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
    return Marker(
      point: LatLng(place.point.latitude, place.point.longitude),
        builder: (BuildContext context) {
          return const Icon(
            Icons.location_on,
            size: 40
          );
        }
    );
  }
}