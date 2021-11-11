import 'package:flutter/material.dart';
import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_model.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_top_bar.dart';
import 'package:harmony/widgets/filter/filter_sheet/mixin&interface/filter_sheet_creator.dart';
import 'package:harmony/widgets/filter/filter_sheet/mixin&interface/uses_filter_sheet.dart';
import 'package:harmony/widgets/general_use/harmony_bottom_navigation_bar.dart';
import 'package:harmony/widgets/place_listview/places_near_user_listview_widget.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);
  @override
  DiscoverPageState createState() => DiscoverPageState();
}


class DiscoverPageState extends State<DiscoverPage> with FilterSheetCreator implements UsesFilterSheet{

  @override
  FilterModel filterModel = FilterModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            ///TOP BAR
            FilterTopBar(
              launchFilterSheet,
              "Discover"
            ),
            ///Show actual places
            Expanded(
              flex: 9,
              child: PlaceNearListViewWidget(
                filterModel
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

  @override
  void launchFilterSheet() {
    toFilterSheet(
        context,
        filterModel,
        onUpdatedFilters
    );
  }

  @override
  void onUpdatedFilters(FilterModel filterModel) {
    setState(() {
      this.filterModel = filterModel;
    });
  }

}

