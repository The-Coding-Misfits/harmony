import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/utilites/constants.dart';

class PlacePopup extends StatefulWidget {
  final Place place;

  const PlacePopup(this.place, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlacePopupState();
}

class _PlacePopupState extends State<PlacePopup> {
  late final Place place = widget.place;


  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            kSpotInfoRouteName,
              arguments: {
                "place": place,
                "distance": null,
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
              'Position: ${place.point.latitude}, ${place.point.longitude}',
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}