import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';
import 'package:harmony/widgets/filter/category_widgets/category_item.dart';
import 'package:harmony/widgets/filter/category_widgets/category_model.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_sheet_controller.dart';

class CategoryGrid extends StatefulWidget {
  final FilterSheetController controller;

  const CategoryGrid(this.controller);

  @override
  _CategoryGridState createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {

  List<CategoryModel> selectedItems = [];

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
      shrinkWrap: true,
      itemCount: items.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index){
        return Padding(
          padding: const EdgeInsets.only(right: 5),
          child: SizedBox(
            width: 50,
            height: 30,
            child: InkWell(
              splashColor: CategoryItem.activeColor,
              onTap: (){
                setState(() {
                  CategoryModel item = items[index];
                  handleCategoryClicked(item);
                });
              },
              child: CategoryItem(items[index]),
            ),
          )
        );
      },
    );
  }

  void handleCategoryClicked(CategoryModel item){
    if(item.isSelected == true){
      categoryDisable(item);
    }else {
      categoryEnable(item);
    }
  }

  void categoryDisable(CategoryModel item){
    item.isSelected = false;
    selectedItems.remove(item);
  }

  void categoryEnable(CategoryModel item){
    item.isSelected = true;
    selectedItems.add(item);

  }
}
