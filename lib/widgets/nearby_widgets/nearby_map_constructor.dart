import 'package:flutter/cupertino.dart';
import 'package:harmony/widgets/general_use/map_widgets/harmony_add_place_map.dart';
import 'package:harmony/widgets/general_use/map_widgets/harmony_nearby_map.dart';
import 'package:harmony/widgets/future_builders/location_future_builder.dart';
import 'package:location/location.dart';

class NearbyMapBuilder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LocationFutureBuilder(
      onLocationGotCallback
    );
  }

  Widget onLocationGotCallback(LocationData userLocation){
    return HarmonyNearbyMap(latitude: userLocation.latitude!, longitude: userLocation.longitude!);
  }
}
