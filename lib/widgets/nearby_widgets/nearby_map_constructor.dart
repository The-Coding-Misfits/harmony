import 'package:flutter/cupertino.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_model.dart';
import 'package:harmony/widgets/future_builders/places_near_future_builder.dart';
import 'package:harmony/widgets/future_builders/location_future_builder.dart';
import 'package:harmony/widgets/general_use/map_widgets/harmony_nearby_map.dart';
import 'package:location/location.dart';

class NearbyMapBuilder extends StatefulWidget {


  final FilterModel filterModel;
  NearbyMapBuilder(this.filterModel, {Key? key}) : super(key: key);

  @override
  State<NearbyMapBuilder> createState() => _NearbyMapBuilderState();
}

class _NearbyMapBuilderState extends State<NearbyMapBuilder> {
  late LocationData userLocation;
  @override
  Widget build(BuildContext context) {
    return LocationFutureBuilder(
      onLocationGotCallback
    );
  }

  Widget onLocationGotCallback(LocationData userLocation){
    this.userLocation = userLocation;
    return PlacesNearFutureBuilder(onNearPlacesGot, userLocation, widget.filterModel);
  }

  Widget onNearPlacesGot(List<Place> nearPlaces){
    return HarmonyNearbyMap(
        userLocation: userLocation,
      placesNear: nearPlaces,
    );
  }
}
