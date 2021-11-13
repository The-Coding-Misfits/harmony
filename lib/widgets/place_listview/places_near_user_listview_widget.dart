import 'package:flutter/material.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_model.dart';
import 'package:harmony/widgets/future_builders/location_future_builder.dart';
import 'package:harmony/widgets/place_listview/sub_listviews/places_near_user.dart';
import 'package:location/location.dart';

class PlaceNearListViewWidget extends StatelessWidget {
  final FilterModel filterModel;
  const PlaceNearListViewWidget(this.filterModel);
  @override
  Widget build(BuildContext context) {
    print("building place near");
    return LocationFutureBuilder(
      createPlaceNearUserListViewWidget
    );
  }

  Widget createPlaceNearUserListViewWidget(LocationData userLocation){
    return PlacesNearUserListView(filterModel, userLocation);
  }
}
