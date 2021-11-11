import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';
import 'place_formulas.dart';
import 'package:harmony/widgets/general_use/place_card.dart';
import 'package:location/location.dart';
import 'package:harmony/services/firestore.dart';

class PlaceListView extends StatelessWidget {
  final LocationData userLocation;
  final List<Place> places;
  const PlaceListView(this.userLocation, this.places);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        Place currPlace = places.elementAt(index);

        return FutureBuilder(
          future: createPlaceCard(currPlace),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: const [
                        Align(
                          alignment: Alignment.center,
                          child: Text("Error loading spot!"),
                        )
                      ],
                    ),
                  ),
                );
              }
              return snapshot.data;
            }

            return const Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text("Loading spot..."),
            );
          },
        );
      },
    );
  }

  Future<PlaceCard> createPlaceCard(Place currPlace) async {
    double dist = calculateDistanceBetweenTwoPoints(currPlace.point.longitude, userLocation.longitude!, currPlace.point.latitude, userLocation.latitude!);
    return PlaceCard(
      distance: roundDouble(dist, 3),
      place: currPlace,
      imageUrl: await FireStoreService().getCoverFromId(currPlace.id),
    );
  }
}
