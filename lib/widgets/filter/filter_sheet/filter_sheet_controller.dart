import 'package:harmony/utilites/places/place_category_enum.dart';

class FilterSheetController{
  /// FILTER VARIABLES
  static double sliderStartingValue = 5;
  static int minRatingStartValue = 3;
  double sliderValue = sliderStartingValue;
  List<PlaceCategory> chosenCategories = [];
  int minimumRating = minRatingStartValue;


  final Function(double, int, List<PlaceCategory>) onSaveCallback;

  FilterSheetController(this.onSaveCallback);

  void saved(){
    onSaveCallback(sliderValue, minimumRating, chosenCategories);
  }

  void setSliderValue(double newSliderValue){
    sliderValue = newSliderValue; //well no reason for double but its too late now
  }

  void setChosenCategories(List<PlaceCategory> newChosenCategories){
    chosenCategories = newChosenCategories;
  }

  void setMinimumRating(int newMinimumRating){
    minimumRating = newMinimumRating;
  }
}