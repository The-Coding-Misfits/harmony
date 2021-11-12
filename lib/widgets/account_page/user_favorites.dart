import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/services/auth_service.dart';
import 'package:harmony/services/firestore.dart';
import 'package:harmony/widgets/general_use/place_card.dart';

class UserFavorites extends StatefulWidget {
  const UserFavorites({Key? key}) : super(key: key);

  @override
  UserFavoritesState createState() => UserFavoritesState();
}

class UserFavoritesState extends State<UserFavorites> {
  HarmonyUser? user = AuthService.currHarmonyUser;

  @override
  Widget build(BuildContext context) {
    if (user!.favoritesID.isEmpty) {
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
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2
            ),
            shrinkWrap: true,
            itemCount: user!.favoritesID.length,
            itemBuilder: (BuildContext context, int index) {
              var placeId = user!.favoritesID[index];

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