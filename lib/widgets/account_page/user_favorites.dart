import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/models/user.dart';

import 'package:harmony/services/firestore.dart';
import 'package:harmony/widgets/general_use/place_card.dart';

class UserFavorites extends StatelessWidget {
  final HarmonyUser user;


  UserFavorites(this.user);

  Widget build(BuildContext context) {
    if (user.favoritesID.isEmpty) {
      return Expanded(
        child: Container(
          color: const Color(0xffefefef),
          child: const Align(
            alignment: Alignment.center,
            child: Text("No favorites!"),
          ),
        )
      );
    } else {
      return Expanded(
        child: Container(
          color: const Color(0xffefefef),
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
            shrinkWrap: true,
            itemCount: user.favoritesID.length,
            itemBuilder: (BuildContext context, int index) {
              var placeId = user.favoritesID[index];

              return FutureBuilder(
                future: FireStoreService().getPlaceFromId(placeId),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Place place = snapshot.data;

                    return FutureBuilder(
                      future: FireStoreService().getCoverFromId(placeId),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return PlaceCard(
                            contentSize: 17,
                            imageUrl: snapshot.data,
                            place: place,
                          );
                        }

                        return const Align(
                          alignment: Alignment.center,
                          child: Text("Loading spot card..."),
                        );
                      },
                    );
                  }

                  return const Text("Loading spot...");
                },
              );
            },
          ),
        )
      );
    }
  }
}