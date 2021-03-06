import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/services/auth_service.dart';
import 'package:harmony/services/firestore.dart';
import 'package:harmony/services/location_service.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';
import 'package:harmony/widgets/filter/category_widgets/category_grid.dart';
import 'package:harmony/widgets/general_use/map_widgets/harmony_add_place_map.dart';
import 'package:harmony/widgets/general_use/review/review_card.dart';
import 'package:harmony/widgets/login_register/harmony_shiny_button.dart';
import 'package:harmony/widgets/place_listview/sub_listviews/place_formulas.dart';
import 'package:harmony/widgets/spot_info/create_review_button.dart';
import 'package:harmony/widgets/spot_info/favorite_widget.dart';
import 'package:location/location.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:harmony/widgets/general_use/rating_widget.dart';

class SpotInfo extends StatefulWidget {

  const SpotInfo({Key? key}) : super(key: key);

  @override
  SpotInfoState createState() => SpotInfoState();
}

class SpotInfoState extends State<SpotInfo> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    Place place = args["place"] as Place;
    double? distance = args["distance"];
    String? imageUrl = args["imageUrl"];

    Widget distanceWidget = distance != null ? Text(" ${place.rating}/5.0 • ${distance.toStringAsFixed(1)}KM Nearby",
        style: const TextStyle(
            fontSize: 16,
            color: Color(0xff6a6a6a),
            fontWeight: FontWeight.bold
        )
    ) : FutureBuilder(
      future: LocationService().getLocation(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          LocationData userLocation = snapshot.data;

          double dist = calculateDistanceBetweenTwoPoints(place.point.longitude, userLocation.longitude!, place.point.latitude, userLocation.latitude!);

          return Text(" ${place.rating}/5.0 • ${dist.toStringAsFixed(1)}KM Nearby",
              style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff6a6a6a),
                  fontWeight: FontWeight.bold
              )
          );
        }

        return const Text(" Loading distance...", style: TextStyle(
            fontSize: 16,
            color: Color(0xff6a6a6a),
            fontWeight: FontWeight.bold
        ));
      },
    );

    Widget imageUrlWidget = imageUrl != null ? Image.network(
      imageUrl,
      scale: 1
    ) : FutureBuilder(
      future: FireStoreService().getCoverFromId(place.id),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          imageUrl = snapshot.data;

          return Image.network(imageUrl!, scale: 1);
        }

        return const Text("Loading cover...");
      },
    );

    Widget reviewsWidget = place.reviewIds.isEmpty ? const Align(
      alignment: Alignment.centerLeft,
      child: Text(
          "0 Reviews",
          style: TextStyle(fontSize: 22)
      ),
    ) : Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
              place.reviewIds.length == 1 ? "1 Review" : "${place.reviewIds.length} Reviews",
              style: const TextStyle(fontSize: 22)
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 0, bottom: 0),
          child: Divider(),
        ),
        SafeArea(
          top: false,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: place.reviewIds.length,
            itemBuilder: (BuildContext context, int index) {
              String currReviewId = place.reviewIds[index];

              return FutureBuilder(
                future: FireStoreService().getReviewFromId(currReviewId),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ReviewCard.forSpotInfo(
                      snapshot.data,
                      15,
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Row(
                        children: const [
                          CircularProgressIndicator(),
                          Text("Loading review...")
                        ],
                      ),
                    );
                  }
                },
              );
            },
          ),
        )
      ],
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Spot Details", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white38,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.directions),
            onPressed: () async {
              final availableMaps = await MapLauncher.installedMaps;

              await availableMaps.first.showMarker(
                  coords: Coords(place.point.latitude, place.point.longitude),
                  title: place.name
              );
            },
          ),
          AuthService.currHarmonyUser!.reviewIds.any((item) => place.reviewIds.contains(item))
              ? const SizedBox(width: 0, height: 0)
              : CreateReviewIconButton(place),
          FavoriteIconButton(place: place),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: Stack(
                children: [
                  SizedBox(
                      height: 350,
                      width: MediaQuery.of(context).size.width,
                      child: HarmonyAddPlaceMap(
                        latitude: place.point.latitude,
                        longitude: place.point.longitude,

                      )
                  ),
                  Positioned.fill(
                    top: 200,
                    child: Container(
                      height: 30,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0x00FFFFFF),
                              Color(0xFFFFFFFF)
                            ]
                        ),
                      ),
                    ),
                  )
                ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  place.name,
                  style: const TextStyle(
                      fontSize: 22,
                    fontWeight: FontWeight.bold,

                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 5, left: 10, top: 10),
                  child: Row(
                    children: [
                      RatingWidget(place.rating, 20),
                      distanceWidget
                    ],
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 10),
              child: SizedBox(
                height: 50,
                width: 500,
                child: CategoryGrid.isDisplay(
                    [PlaceCategory.values.firstWhere((e) => e == place.category)]
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: imageUrlWidget
                )
            ),
            usersCountWidget(place),
            HarmonyShinyButton(
              "Check-In",
              () {
                if (!checkIfCheckedIn(place)) {
                  FireStoreService().checkInUser(AuthService.currHarmonyUser!, Timestamp.now(), place);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Successfully checked you in!"))
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("You already checked in to this spot!"))
                  );
                }
              },
              isActive: !checkIfCheckedIn(place),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                child: reviewsWidget
            ),
          ],
        ),
      ),
    );
  }

  Widget usersCountWidget(Place place) {
    int listLength = place.pastUserIds.length;
    String text;

    if (listLength == 0) {
      text = "No user was here before!";
    } else if (listLength == 1) {
      text = "1 User have been here before!";
    } else {
      text = "${place.pastUserIds.length} Users have been here before!";
    }

    return Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 20
            ),
          ),
        )
    );
  }

  bool checkIfCheckedIn(Place place) {
    HarmonyUser user = AuthService.currHarmonyUser!;

    if (place.pastUserIds.contains(user.id)) {
      return true;
    } else {
      return false;
    }
  }
}