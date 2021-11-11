import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/services/firestore.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';
import 'package:harmony/widgets/place_listview/sub_listviews/place_list_view.dart';
import 'package:location/location.dart';

class PlacesNearUserListView extends StatelessWidget {
  final double proximity;
  final LocationData userLocation;
  final List<PlaceCategory> categoriesEligible;
  final int minRating;
  const PlacesNearUserListView(
      this.proximity, this.userLocation, this.categoriesEligible, this.minRating);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Place>>(
      future: FireStoreService().getPlacesNearUser(proximity, userLocation, categoriesEligible, minRating),
      builder: (BuildContext context, AsyncSnapshot<List<Place>> placesSnapshot){
        if (placesSnapshot.hasData){
          List<Place> data = placesSnapshot.data!;

          if (data.isEmpty) {
            return const Align(
              alignment: Alignment.center,
              child: Text("No spots found nearby!"),
            );
          } else {
            return PlaceListView(proximity, userLocation, data);
          }
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
