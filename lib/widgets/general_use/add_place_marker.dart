import 'package:flutter/material.dart';
import 'package:harmony/utilites/constants.dart';

class AddPlaceMarker extends StatelessWidget {
  final double minRadius;
  final double  maxRadius;
  final double iconSize;
  const AddPlaceMarker(this.minRadius, this.maxRadius, this.iconSize);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: kHarmonyColor,
      minRadius: minRadius,
      maxRadius: maxRadius,
      child: Icon(
        Icons.add,
        size: iconSize,
        color: Colors.white,
      ),
    );
  }
}
