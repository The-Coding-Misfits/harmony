import 'package:flutter/material.dart';
import 'package:harmony/services/location_service.dart';
import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/viewmodel/discover/discover_page_viewmodel.dart';
import 'package:harmony/widgets/filter/filter_sheet/uses_filter_sheet.dart';
import 'package:harmony/widgets/general_use/hamburger_button.dart';
import 'package:harmony/widgets/general_use/place_card.dart';
import 'package:harmony/widgets/general_use/harmony_bottom_navigation_bar.dart';
import 'package:harmony/services/auth_service.dart';

class DiscoverPage extends StatefulWidget {

  final DiscoverPageViewModel _discoverPageViewModel = DiscoverPageViewModel();

  DiscoverPage({Key? key}) : super(key: key);

  @override
  DiscoverPageState createState() => DiscoverPageState();
}


class DiscoverPageState extends State<DiscoverPage> with UsesFilterSheet{
  final AuthService authService = AuthService();
  final LocationService locationService = LocationService();

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
                  onPressed: (){toFilterSheet(context, onFilterSheetClosed);},
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
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index){
                  return const PlaceCard(
                    rating: 2.8,
                    imageUrl: "assets/images/dummy-national-park.jpg",
                    distance: 1.2
                  );
                },
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

  void onFilterSheetClosed(){

  }


}

