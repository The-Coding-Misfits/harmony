import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/services/location_service.dart';
import 'package:harmony/widgets/general_use/map_widgets/harmony_add_place_map.dart';
import 'package:harmony/widgets/place_listview/sub_listviews/place_formulas.dart';
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
    String imageUrl = args["imageUrl"];

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

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Spot Details", style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0x11000000),
        foregroundColor: Colors.black,
        actions: [
          FavoriteIconButton(place: place)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: HarmonyAddPlaceMap(
                    latitude: place.point.latitude,
                    longitude: place.point.longitude,

                )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  place.name,
                  style: const TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 5, left: 10, top: 5),
                  child: Row(
                    children: [
                      RatingWidget(place.rating, 20),
                      distanceWidget
                    ],
                  )
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Image.network(imageUrl, scale: 6)
                )
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("${place.reviewIds.length} Reviews", style: const TextStyle(fontSize: 22))
                )
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final availableMaps = await MapLauncher.installedMaps;

          await availableMaps.first.showMarker(
            coords: Coords(place.point.latitude, place.point.longitude),
            title: place.name
          );
        },
        icon: const Icon(FontAwesomeIcons.directions),
        label: const Text("Get Directions"),
      ),
    );
  }
}