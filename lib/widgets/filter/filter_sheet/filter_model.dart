import 'package:harmony/utilites/places/place_category_enum.dart';

class FilterModel{
  static double startingProximityValue = 5;
  static int minRatingStartValue = 3;
  static List<PlaceCategory> startingCategories = [];
  double proximity = startingProximityValue;
  List<PlaceCategory> chosenCategories = startingCategories;
  int minimumRating = minRatingStartValue;
}