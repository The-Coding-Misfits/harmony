import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:harmony/models/place.dart';

class PlacePopup extends StatefulWidget {
  final Place place;

  const PlacePopup(this.place, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlacePopupState();
}

class _PlacePopupState extends State<PlacePopup> {
  late final Place place = widget.place;

  final List<IconData> _icons = [
    Icons.star_border,
    Icons.star_half,
    Icons.star
  ];
  int _currentIcon = 0;


  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => setState(() {
          _currentIcon = (_currentIcon + 1) % _icons.length;
        }),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Icon(_icons[_currentIcon]),
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
        constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Popup for a marker!',
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
            Text(
              'Marker size: }',
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}