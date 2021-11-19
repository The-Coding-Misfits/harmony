import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_model.dart';
import 'package:harmony/widgets/future_builders/places_near_future_builder.dart';
import 'package:harmony/widgets/general_use/map_widgets/harmony_nearby_map.dart';
import 'package:location/location.dart';

class NearbyOnLocationBuilder extends StatelessWidget {
  final FilterModel filterModel;
  final LocationData userLocation;


  NearbyOnLocationBuilder(this.filterModel, this.userLocation);

  @override
  Widget build(BuildContext context) {
    return PlacesNearFutureBuilder(
        onNearPlacesGot,
        userLocation,
        filterModel);
  }

  Widget onNearPlacesGot(List<Place> nearPlaces, FilterModel filterModel){
    print(nearPlaces);
    return HarmonyNearbyMap(
      userLocation: userLocation,
      placesNear: nearPlaces,
      filterModel: filterModel,
    );
  }
}
