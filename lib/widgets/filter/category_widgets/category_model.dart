import 'package:flutter/cupertino.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';

class CategoryModel{
  bool isSelected;
  IconData iconData;
  PlaceCategory category;

  CategoryModel(this.isSelected, this.iconData, this.category);
}