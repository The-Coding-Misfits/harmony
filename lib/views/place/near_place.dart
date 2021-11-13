import 'package:flutter/material.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_model.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_top_bar.dart';
import 'package:harmony/widgets/filter/filter_sheet/mixin&interface/filter_sheet_creator.dart';
import 'package:harmony/widgets/filter/filter_sheet/mixin&interface/uses_filter_sheet.dart';
import 'package:harmony/widgets/general_use/add_place_marker.dart';
import 'package:harmony/widgets/general_use/harmony_bottom_navigation_bar.dart';
import 'package:harmony/widgets/general_use/map_widgets/harmony_add_place_map.dart';
import 'package:harmony/widgets/general_use/map_widgets/harmony_nearby_map.dart';
import 'package:harmony/widgets/nearby_widgets/nearby_map_constructor.dart';

class NearbyPage extends StatefulWidget {
  const NearbyPage({Key? key}) : super(key: key);

  @override
  _NearbyPageState createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> with FilterSheetCreator implements UsesFilterSheet{

  @override
  FilterModel filterModel = FilterModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            FilterTopBar(
              launchFilterSheet,
              "Nearby"
            ),
            Expanded(
              flex: 9,
              child: NearbyMapBuilder(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: HarmonyBottomNavigationBar(
        PAGE_ENUM.NEARBY_PAGE,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed( // we want the animation
            context,
            kAddPlacePageRouteName
          );
        },
        child: const AddPlaceMarker(
          35,
          45,
          30
        ),

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
