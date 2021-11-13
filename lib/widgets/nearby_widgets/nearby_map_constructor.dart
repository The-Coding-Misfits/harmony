import 'package:flutter/cupertino.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_model.dart';
import 'package:harmony/widgets/future_builders/location_future_builder.dart';
import 'package:harmony/widgets/nearby_widgets/nearby_on_location_builder.dart';
import 'package:location/location.dart';

class NearbyMapBuilder extends StatelessWidget {
  final FilterModel filterModel;
  const NearbyMapBuilder(this.filterModel, {Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    print("build map");
    print(filterModel.minimumRating);
    filterModel; //hack, we want to build map again but cant because this function is not dirty
    return LocationFutureBuilder(
      onLocationGotCallback
    );
  }

  Widget onLocationGotCallback(LocationData userLocation){
    print("got location");
    print(userLocation.latitude!);
    return NearbyOnLocationBuilder(filterModel, userLocation);
  }
}
