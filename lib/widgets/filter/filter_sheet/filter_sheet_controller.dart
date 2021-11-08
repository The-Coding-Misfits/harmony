import 'package:harmony/utilites/places/place_category_enum.dart';

class FilterSheetController{
  /// FILTER VARIABLES
  static double sliderStartingValue = 5;
  double sliderValue = sliderStartingValue;
  List<PlaceCategory> chosenCategories = [PlaceCategory.TREKKING];
  double minimumRating = 3;

  void setSliderValue(double newSliderValue ){
    sliderValue = newSliderValue;
  }
}