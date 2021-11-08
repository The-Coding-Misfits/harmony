import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';
import 'place_formulas.dart';
import 'package:harmony/widgets/general_use/place_card.dart';
import 'package:location/location.dart';

class PlaceListView extends StatelessWidget {

  final double proximity;
  final LocationData userLocation;
  final List<Place> places;
  const PlaceListView(this.proximity, this.userLocation, this.places);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index){
        Place currPlace = places.elementAt(index);
        return createPlaceCard(currPlace);
      },
    );
  }

  PlaceCard createPlaceCard(Place currPlace){
    double dist = calculateDistanceBetweenTwoPoints(currPlace.point.longitude, userLocation.longitude!, currPlace.point.latitude, userLocation.latitude!);
    return PlaceCard(
      distance: roundDouble(dist, 3),
      rating: currPlace.rating,
      imageUrl: "",
    );
  }
}
