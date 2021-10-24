import 'package:flutter/material.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';
import 'package:harmony/viewmodel/discover/discover_page_viewmodel.dart';
import 'package:harmony/widgets/filter/harmony_slider.dart';

class FilterSheet extends StatefulWidget {
  final BuildContext context;
  final DiscoverPageViewModel discoverPageViewModel;

  FilterSheet(this.context, this.discoverPageViewModel);

  @override
  _FilterSheetState createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  //initialize with initial values
  int farValue = 5;
  PlaceCategory chosenCategory = PlaceCategory.TREKKING;
  double minimumRating = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Flexible( //To make space for the top bar
            flex: 1,
            child: SizedBox(),
          ),
          Flexible( //Rest of filtering sheet
              flex: 5,
              child: getFilterSlider()
          )
        ],
      ),

    );
  }


  Column getFilterSlider(){
    return Column(
      children: [
        const Text(
          "How far from you?",
          style: TextStyle(
            fontWeight: FontWeight.w300
          ),
        ),
        const SizedBox(height: 7,),
        HarmonySlider(
            widget.discoverPageViewModel.setSliderValue,
            1,
            15,
            5
        ),
        SizedBox(height: 7,)
      ],
    );
  }



}
