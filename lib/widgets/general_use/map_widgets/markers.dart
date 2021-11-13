import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/widgets/general_use/add_place_marker.dart';

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

  LocationMarkerLayerOptions getAddPlacePageMarker(){
    return LocationMarkerLayerOptions(
      marker: const DefaultLocationMarker(
        color: kHarmonyColor,
        child: Hero(
          tag : AddPlaceMarker.markerTag,
          child: AddPlaceMarker(
            20,
            30,
            15
          ),
        ),
      ),
      markerSize: const Size(25, 25),
      accuracyCircleColor: kHarmonyColor.withOpacity(0.4),
      headingSectorColor: Colors.transparent,
      headingSectorRadius: 0,
      markerAnimationDuration: Duration.zero, // disable animation
    );
  }

  Marker createPlaceMarker(){

  }
}