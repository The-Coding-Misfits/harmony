import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/widgets/place_listview/sub_listviews/place_formulas.dart';
import 'package:location/location.dart';

class PlacePopup extends StatefulWidget {
  final Place place;
  final LocationData userLocation;

  const PlacePopup(this.place, this.userLocation, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlacePopupState();
}

class _PlacePopupState extends State<PlacePopup> {
  late final Place place = widget.place;
  late double dist;

  @override
  Widget build(BuildContext context) {
    dist = calculateDistanceBetweenTwoPoints(place.point.longitude, widget.userLocation.longitude!, place.point.latitude, widget.userLocation.latitude!);

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            kSpotInfoRouteName,
              arguments: {
                "place": place,
                "distance": dist,
                "imageUrl": null,
              }
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 5),
              child: Icon(Icons.map),
            ),
            _cardDescription(context),
          ],
        ),
      ),
    );
  }

  Widget _cardDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.place.name,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              "Distance: ${dist.toStringAsFixed(1)}KM",
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}