import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/models/user.dart';

import 'package:harmony/services/firestore.dart';
import 'package:harmony/widgets/general_use/place_card.dart';

class UserFavorites extends StatelessWidget {
  final HarmonyUser user;
  const UserFavorites(this.user);

  @override
  Widget build(BuildContext context) {
    if (user.favoritesID.isEmpty) {
      return getEmptyWidget();
    }
    return SliverStaggeredGrid.countBuilder(
      crossAxisCount: 2,
      staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
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
    );
  }

  Widget getEmptyWidget(){
    return SliverToBoxAdapter(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Container(
            child: const Text(
              "No favorites!"
            ),
          ),
        ),
      ),
    );
  }
}
