import 'package:flutter/material.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_sheet_controller.dart';
import 'package:harmony/widgets/filter/slider/harmony_slider.dart';

class FilterSheet extends StatefulWidget {
  final BuildContext context;
  final FilterSheetController _controller = FilterSheetController();

  FilterSheet(this.context, {Key? key}) : super(key: key);

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
    return Column(
      children: [
        ///SLIDER
        const Text(
          "How far from you?",
          style: TextStyle(
              fontWeight: FontWeight.w300
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: HarmonySlider(
              widget._controller.setSliderValue,
              1,
              15,
              5
          ),
        )


        ///CATEGORY


        ///RECOMMENDATION
      ],
    );
  }
}
