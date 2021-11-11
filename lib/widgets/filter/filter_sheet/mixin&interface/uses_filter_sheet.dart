import '../filter_model.dart';

abstract class UsesFilterSheet {
  FilterModel filterModel = FilterModel();
  void launchFilterSheet();
  void onUpdatedFilters();

}