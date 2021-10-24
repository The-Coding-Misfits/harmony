import 'package:flutter/material.dart';
import 'package:harmony/widgets/filter/category_widgets/category_model.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel _item;

  static const Color activeColor = Color(0xFF5F5D70);
  static const Color inactiveColor = Color(0xffececec);
  static const Color iconActiveColor = Color(0xffececec);
  static const Color iconInactiveColor = Color(0xFF5F5D70);

  CategoryItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      alignment: Alignment.center,
      child: Center(
        child: Icon(
          _item.iconData,
          color: _item.isSelected ? iconActiveColor : iconInactiveColor,
        ),
      ),
      color: _item.isSelected ? activeColor : inactiveColor,
    );
  }
}
