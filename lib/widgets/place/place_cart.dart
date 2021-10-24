import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';

class PlaceCard extends StatelessWidget {

  final Place _place;
  const PlaceCard(this._place);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 3/2,
              child: Container(), //TODO
            ),
          )
        ],
      ),
    );
  }
}
