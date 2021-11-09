import 'package:flutter/material.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';
import 'package:harmony/widgets/location_widgets/location_future_builder.dart';
import 'package:harmony/widgets/place_listview/sub_listviews/places_near_user.dart';
import 'package:location/location.dart';

class PlaceNearListViewWidget extends StatelessWidget {
  final double proximity;
  final List<PlaceCategory> categoriesEligible;
  final int minRating;
  const PlaceNearListViewWidget(this.proximity, this.categoriesEligible, this.minRating);
  @override
  Widget build(BuildContext context) {
    return LocationFutureBuilder(
      createPlaceNearUserListViewWidget
    );
  }

  Widget createPlaceNearUserListViewWidget(LocationData userLocation){
    return PlacesNearUserListView(proximity, userLocation, categoriesEligible, minRating);
  }
}
