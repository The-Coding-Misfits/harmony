import 'package:flutter/cupertino.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_model.dart';
import 'package:harmony/widgets/future_builders/places_near_future_builder.dart';
import 'package:harmony/widgets/future_builders/location_future_builder.dart';
import 'package:harmony/widgets/general_use/map_widgets/harmony_nearby_map.dart';
import 'package:location/location.dart';

class NearbyMapBuilder extends StatelessWidget {

  late final LocationData userLocation;
  final FilterModel filterModel;
  NearbyMapBuilder(this.filterModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LocationFutureBuilder(
      onLocationGotCallback
    );
  }

  Widget onLocationGotCallback(LocationData userLocation){
    this.userLocation = userLocation;
    return PlacesNearFutureBuilder(onNearPlacesGot, userLocation, filterModel);
  }

  Widget onNearPlacesGot(List<Place> nearPlaces){
    return HarmonyNearbyMap(
        latitude: userLocation.latitude!,
        longitude: userLocation.longitude!,
        places: nearPlaces,
    );
  }
}
