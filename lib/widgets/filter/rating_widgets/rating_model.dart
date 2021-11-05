import 'package:flutter/material.dart';

class RatingModel {
  bool isSelected;
  int rating;
  IconData iconData = Icons.circle;

  RatingModel(this.isSelected, this.rating);
}