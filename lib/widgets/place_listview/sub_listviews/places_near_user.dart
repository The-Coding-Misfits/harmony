import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_model.dart';
import 'package:harmony/widgets/future_builders/near_places_future_builder.dart';
import 'package:harmony/widgets/place_listview/sub_listviews/place_list_view.dart';
import 'package:location/location.dart';

class PlacesNearUserListView extends StatelessWidget {
  final FilterModel filterModel;
  final LocationData userLocation;
  const PlacesNearUserListView(this.filterModel, this.userLocation, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NearPlaceFutureBuilder(
        onGotNearPlaces,
        userLocation,
        filterModel
    );
  }

  Widget onGotNearPlaces(List<Place> nearPlaces){
    return PlaceListView(userLocation, nearPlaces);
  }
}
