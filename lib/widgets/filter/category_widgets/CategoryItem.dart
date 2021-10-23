import 'package:flutter/material.dart';
import 'package:harmony/widgets/filter/category_widgets/CategoryModel.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel _item;
  static final Color activeColor = Color(0xFF5F5D70);
  static final Color inactiveColor = Color(0xffececec);
  CategoryItem(this._item);




  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: Icon(
          _item.iconData
        ),
      ),
      color: _item.isSelected ? activeColor : inactiveColor,
    );
  }
}
