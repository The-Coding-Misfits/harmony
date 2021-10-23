import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';
import 'package:harmony/widgets/filter/category_widgets/CategoryGridController.dart';
import 'package:harmony/widgets/filter/category_widgets/CategoryItem.dart';
import 'package:harmony/widgets/filter/category_widgets/CategoryModel.dart';

class CategoryGrid extends StatefulWidget {
  final CategoryGridController categoryGridController = CategoryGridController();
  @override
  _CategoryGridState createState() => _CategoryGridState();

  PlaceCategory? get selectedCategory => categoryGridController.selectedCategory;
}

class _CategoryGridState extends State<CategoryGrid> {

  List<CategoryModel> items = [
    CategoryModel(false, Icons.backpack, PlaceCategory.TREKKING),
    CategoryModel(false, FontAwesomeIcons.bicycle, PlaceCategory.CYCLING),
    CategoryModel(false, FontAwesomeIcons.swimmer, PlaceCategory.SWIMMING),
    CategoryModel(false, FontAwesomeIcons.running, PlaceCategory.RUNNING),
    CategoryModel(false, FontAwesomeIcons.campground, PlaceCategory.CAMPING),
    CategoryModel(false, FontAwesomeIcons.paw, PlaceCategory.WILDLIFE),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index){
        return InkWell(
          splashColor: CategoryItem.activeColor,
          onTap: (){
            setState(() {
              items.forEach((element) => element.isSelected = false);
              items[index].isSelected = true;
              widget.categoryGridController.selectedCategory = items[index].category;
            });
          },
          child: CategoryItem(items[index]),
        );
      },
    );
  }
}
