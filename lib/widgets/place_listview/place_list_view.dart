import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/services/firestore.dart';
import 'place_formulas.dart';
import 'package:harmony/widgets/general_use/place_card.dart';
import 'package:location/location.dart';

class PlaceListView extends StatelessWidget {

  final double proximity;
  final LocationData userLocation;
  const PlaceListView(this.proximity, this.userLocation, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Place>>(
      future: FireStoreService().getPlacesNearUser(proximity, userLocation),
      builder: (BuildContext context, AsyncSnapshot<List<Place>> placesSnapshot){
        if (placesSnapshot.hasData){
          return ListView.builder(
            itemCount: placesSnapshot.data!.length,
            itemBuilder: (context, index){
              Place currPlace = placesSnapshot.data!.elementAt(index);
              return createPlaceCard(currPlace);
            },
          );
        }
        else {
          return CircularProgressIndicator(

          );
        }
      },
    );
  }

  PlaceCard createPlaceCard(Place currPlace){
    double dist = calculateDistanceBetweenTwoPoints(currPlace.point.longitude, userLocation.longitude!, currPlace.point.latitude, userLocation.latitude!);
    return PlaceCard(
      distance: roundDouble(dist, 3),
      rating: currPlace.rating,
      imageUrl: "",
    );
  }
}
