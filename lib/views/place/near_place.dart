import 'package:flutter/material.dart';
import 'package:harmony/widgets/filter/filter_sheet/uses_filter_sheet.dart';
import 'package:harmony/widgets/general_use/hamburger_button.dart';

class NearbyPage extends StatefulWidget {
  const NearbyPage({Key? key}) : super(key: key);

  @override
  _NearbyPageState createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> with UsesFilterSheet{
  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }


  void updateFilters(double proximity, int minRating, List<PlaceCategory> chosenCategories){
    setState(() {
      this.proximity = proximity;
      this.minRating = minRating;
      this.chosenCategories = chosenCategories;
    });


}
