import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  LocationMarkerLayerOptions getAddPlacePageMarker(){
    return LocationMarkerLayerOptions(
      marker: DefaultLocationMarker(
        color: locationMarkerCircleColor,
        child: const Hero(
          tag : AddPlaceMarker.markerTag,
          child: AddPlaceMarker(
            20,
            30,
            15
          ),
        ),
      ),
      markerSize: const Size(25, 25),
      accuracyCircleColor: locationMarkerCircleColor.withOpacity(0.4),
      headingSectorColor: Colors.transparent,
      headingSectorRadius: 0,
      markerAnimationDuration: Duration.zero, // disable animation
    );
  }

}