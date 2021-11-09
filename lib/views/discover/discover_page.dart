import 'dart:math';

import 'package:flutter/material.dart';
import 'package:harmony/services/location_service.dart';
import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_sheet.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_sheet_controller.dart';
import 'package:harmony/widgets/filter/filter_sheet/uses_filter_sheet.dart';
import 'package:harmony/widgets/general_use/hamburger_button.dart';
import 'package:harmony/widgets/general_use/harmony_bottom_navigation_bar.dart';
import 'package:harmony/services/auth_service.dart';
import 'package:harmony/widgets/place_listview/places_near_user_listview_widget.dart';

class DiscoverPage extends StatefulWidget {
  DiscoverPage({Key? key}) : super(key: key);
  @override
  DiscoverPageState createState() => DiscoverPageState();
}


class DiscoverPageState extends State<DiscoverPage> with UsesFilterSheet{
  final AuthService authService = AuthService();
  final LocationService locationService = LocationService();
  late final FilterSheet filterSheet;


  //filtering vars
  late List<PlaceCategory> chosenCategories;
  late double proximity;
  late int minRating;

  @override
  void initState() {
    super.initState();
    FilterSheetController filterSheetController = FilterSheetController(updateFilters);
    filterSheet = FilterSheet(
      filterSheetController,
    );
    chosenCategories = filterSheetController.chosenCategories;
    proximity = filterSheetController.sliderValue;
    minRating = filterSheetController.minimumRating;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            ///TOP BAR
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HamburgerButton(),
                //App bar title
                const Text(
                  "Discover",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                IconButton( //filter button
                  onPressed: (){
                    toFilterSheet(
                        context,
                        filterSheet,
                      updateFilters
                    );},
                  icon: const Icon(
                    Icons.filter_alt_sharp,
                    size: 25,
                  ),
                )
                ],
              ),
            ),
            ///Show actual places
            Expanded(
              flex: 9,
              child: PlaceNearListViewWidget(
                proximity,
                chosenCategories,
                minRating,
              ),
            ),
          ]
        ),
      ),
      bottomNavigationBar: HarmonyBottomNavigationBar(
        PAGE_ENUM.DISCOVER_PAGE
      ),
    );
  }


  void updateFilters(double proximity, int minRating, List<PlaceCategory> chosenCategories){
    setState(() {
      this.proximity = proximity;
      this.minRating = minRating;
      this.chosenCategories = chosenCategories;
      print(proximity);
      print(minRating);
      print(chosenCategories);
    });
  }


}

