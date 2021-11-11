import 'package:harmony/utilites/places/place_category_enum.dart';
import 'filter_model.dart';
import 'filter_sheet.dart';

class FilterSheetController{
  final FilterSheet filterSheet;
  final FilterModel filterModel;

  late double sliderValue;
  late List<PlaceCategory> chosenCategories;
  late int minimumRating;



  FilterSheetController(this.filterSheet, this.filterModel){
    sliderValue = filterModel.proximity;
    chosenCategories = [...filterModel.chosenCategories]; // deep copy list
    minimumRating = filterModel.minimumRating;

  }

  void setSliderValue(double newSliderValue){
    sliderValue = newSliderValue;
  }

  void setChosenCategories(List<PlaceCategory> newChosenCategories){
    chosenCategories = newChosenCategories;
  }

  void setMinimumRating(int newMinimumRating){
    minimumRating = newMinimumRating;
  }

  void setFilterVariables(){
    filterModel.proximity = sliderValue;
    filterModel.chosenCategories = [...chosenCategories];
    filterModel.minimumRating = minimumRating;
  }

  void clickedSave(){
    setFilterVariables();
    filterSheet.onSavedCallback(filterModel);
  }
}