import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/widgets/general_use/harmony_map.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:harmony/widgets/general_use/rating_widget.dart';
import 'package:harmony/widgets/login_register/harmony_shiny_button.dart';

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
    double distance = args["distance"];
    String imageUrl = args["imageUrl"];

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Spot Details", style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0x11000000),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: HarmonyMap(
                    latitude: place.point.latitude,
                    longitude: place.point.longitude
                )
              ),
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
                      RatingWidget(place.rating),
                      Text(" ${place.rating}/5.0 • ${distance}KM Nearby",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xff6a6a6a),
                              fontWeight: FontWeight.bold
                          )
                      ),
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
                padding: const EdgeInsets.only(top: 10),
                child: Align(
                    alignment: Alignment.center,
                    child: HarmonyShinyButton(
                      "Get directions",
                          () {
                        MapsLauncher.launchCoordinates(place.point.latitude, place.point.longitude);
                      },
                      size: 50,
                    )
                )
            )
          ],
        ),
      )
    );
  }
}