import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harmony/widgets/filter/category_widgets/CategoryGridItem.dart';
import 'package:harmony/widgets/filter/category_widgets/CategoryGridViewModel.dart';

class CategoryGrid extends StatefulWidget {
  const CategoryGrid({Key? key}) : super(key: key);

  @override
  _CategoryGridState createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {

  final CategoryGridViewModel categoryGridViewModel = CategoryGridViewModel(
    true
  );

  List<CategoryGridItem> items = [
    CategoryGridItem(
      Icons.backpack,
      tapped,
      deactivationStream,
      PlaceCategory.TREKKING,

    ),
    CategoryGridItem(
      FontAwesomeIcons.bicycle,
      tapped,
      _deactivationStream,
      PlaceCategory.CYCLING,
    ),
    CategoryGridItem(
      FontAwesomeIcons.swimmer,
      tapped,
      _deactivationStream,
      PlaceCategory.SWIMMING,
    ),
    CategoryGridItem(
      FontAwesomeIcons.running,
      tapped,
      _deactivationStream,
      PlaceCategory.RUNNING,
    ),
    CategoryGridItem(
        FontAwesomeIcons.campground,
        tapped,
        _deactivationStream,
        PlaceCategory.CAMPING
    ),
    CategoryGridItem(
        FontAwesomeIcons.paw,
        tapped,
        _deactivationStream,
        PlaceCategory.WILDLIFE
    ),
  ];





  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 6,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      shrinkWrap: true,
      children: [

      ],
    );
  }
}
