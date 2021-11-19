import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/services/firestore.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_model.dart';
import 'package:location/location.dart';

class PlacesNearFutureBuilder extends StatelessWidget {
  final Function(List<Place>, FilterModel) onNearPlacesGetWidgetCallback;
  final LocationData userLocation;
  final FilterModel filterModel;


  const PlacesNearFutureBuilder(this.onNearPlacesGetWidgetCallback, this.userLocation, this.filterModel);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Place>>(
      future: FireStoreService().getPlacesNearUser(userLocation, filterModel),
      builder: (BuildContext context, AsyncSnapshot<List<Place>> placesSnapshot){
        if (placesSnapshot.hasData){
          List<Place> data = placesSnapshot.data!;
          return onNearPlacesGetWidgetCallback(data, filterModel);
        }
        else if (placesSnapshot.hasError) {
          return Column(
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${placesSnapshot.error}'),
              )
            ],
          );
        }
        else {
          return Column(
            children: const [
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Loading...'),
              )
            ],
          );
        }
      },
    );
  }
}
