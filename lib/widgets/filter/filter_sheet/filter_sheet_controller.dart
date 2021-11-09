import 'package:flutter/cupertino.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';

class FilterSheetController extends ChangeNotifier{
  /// FILTER VARIABLES
  static double sliderStartingValue = 5;
  static int minRatingStartValue = 3;
  double sliderValue = sliderStartingValue;
  List<PlaceCategory> chosenCategories = [PlaceCategory.TREKKING];
  int minimumRating = minRatingStartValue;




  void setSliderValue(double newSliderValue ){
    sliderValue = newSliderValue;
  }

  void setMinRatingValue(int newRatingVal){
    minimumRating = newRatingVal;
  }


}