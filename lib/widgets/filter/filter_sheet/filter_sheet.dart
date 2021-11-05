import 'package:flutter/material.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';
import 'package:harmony/widgets/filter/category_widgets/category_grid.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_sheet_controller.dart';
import 'package:harmony/widgets/filter/slider/harmony_slider.dart';

class FilterSheet extends StatefulWidget {
  final FilterSheetController _controller = FilterSheetController();
  final CategoryGrid _categoryGrid = CategoryGrid();

  FilterSheet({Key? key}) : super(key: key);

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
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Card(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "How far from you?",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                  ),
                  HarmonySlider(
                      widget._controller.setSliderValue,
                      1,
                      15,
                      5
                  ),
                ],
              ),
            ),
          ),




          ///CATEGORY
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 10),
                    child: Text(
                      "What can you do here?",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, left: 5),
                    child: SizedBox(
                        height: 50,
                        width: 500,
                        child: widget._categoryGrid
                    ),
                  )
                ],
              ),
            ),
          )

          ///RECOMMENDATION
        ],
      ),
    );
  }
}
