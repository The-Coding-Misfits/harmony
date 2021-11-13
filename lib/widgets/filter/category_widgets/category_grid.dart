import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';
import 'package:harmony/widgets/filter/category_widgets/category_item.dart';
import 'package:harmony/widgets/filter/category_widgets/category_model.dart';

class CategoryGrid extends StatefulWidget {
  final Function(List<PlaceCategory>) onCategoryChanged;
  final bool isSingleOptionOnly;
  final bool isDisplayOnly;
  final List<PlaceCategory> startingCategories;

  const CategoryGrid(this.onCategoryChanged,this.startingCategories, {Key? key, this.isSingleOptionOnly = false, this.isDisplayOnly = false}) : super(key: key);

  @override
  _CategoryGridState createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {

  List<PlaceCategory> selectedCategories = [];

  List<CategoryModel> items = [
    CategoryModel(false, Icons.backpack, PlaceCategory.TREKKING),
    CategoryModel(false, FontAwesomeIcons.bicycle, PlaceCategory.CYCLING),
    CategoryModel(false, FontAwesomeIcons.swimmer, PlaceCategory.SWIMMING),
    CategoryModel(false, FontAwesomeIcons.running, PlaceCategory.RUNNING),
    CategoryModel(false, FontAwesomeIcons.campground, PlaceCategory.CAMPING),
    CategoryModel(false, FontAwesomeIcons.paw, PlaceCategory.WILDLIFE),
  ];

  @override
  void initState() {
    enableWidgetAccordingToStartingCategories();
    selectedCategories = widget.startingCategories;
    super.initState();
  }

  void enableWidgetAccordingToStartingCategories(){
    for(CategoryModel model in items){
      for (PlaceCategory category in widget.startingCategories){
        if (model.category == category){
          model.isSelected = true;
        }
      }
    }
  }

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
                  if (widget.isDisplayOnly){
                    return;
                  }
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
    widget.onCategoryChanged(selectedCategories);
  }

  void categoryDisable(CategoryModel item){
    item.isSelected = false;
    selectedCategories.remove(item.category);
  }

  void categoryEnable(CategoryModel item){
    if(widget.isSingleOptionOnly){
      disableCurrentActive();
    }
    item.isSelected = true;
    selectedCategories.add(item.category);

  }

  void disableCurrentActive(){
    for (CategoryModel model in items){
      if (model.isSelected){
        model.isSelected = false;
        selectedCategories.remove(model.category);
      }
    }
  }
}
