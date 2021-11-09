import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';

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
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Spot Details", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                place.name,
                style: const TextStyle(
                    fontSize: 20
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 500,
                  height: 300 ,
                  child: Image.asset("assets/images/dummy-national-park.jpg"),
                ),
              )
            )
          ],
        ),
      )
    );
  }
}