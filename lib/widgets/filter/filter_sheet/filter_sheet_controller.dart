import 'package:harmony/utilites/places/place_category_enum.dart';

class FilterSheetController{
  /// FILTER VARIABLES
  double sliderValue = 5;
  List<PlaceCategory> chosenCategories = [PlaceCategory.TREKKING];
  double minimumRating = 3;

  void setSliderValue(double newSliderValue ){
    sliderValue = newSliderValue;
  }
}