import 'package:flutter/material.dart';
import 'package:harmony/services/location_service.dart';
import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_model.dart';
import 'package:harmony/widgets/filter/filter_sheet/uses_filter_sheet.dart';
import 'package:harmony/widgets/general_use/hamburger_button.dart';
import 'package:harmony/widgets/general_use/harmony_bottom_navigation_bar.dart';
import 'package:harmony/services/auth_service.dart';
import 'package:harmony/widgets/place_listview/places_near_user_listview_widget.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);
  @override
  DiscoverPageState createState() => DiscoverPageState();
}


class DiscoverPageState extends State<DiscoverPage> with UsesFilterSheet{
  final AuthService authService = AuthService();
  final LocationService locationService = LocationService();

  FilterModel filterModel = FilterModel();

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
                      filterModel,
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


  void updateFilters(FilterModel filterModel){
    setState(() {
      this.filterModel = filterModel;
    });
  }
}

