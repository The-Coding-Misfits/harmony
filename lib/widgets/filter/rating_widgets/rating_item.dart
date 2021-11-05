import 'package:flutter/material.dart';
import 'package:harmony/widgets/filter/rating_widgets/rating_model.dart';

class RatingItem extends StatelessWidget {
  final RatingModel _item;

  static const Color activeColor = Color(0xFF5F5D70);
  static const Color inactiveColor = Color(0xffDAD9E2);

  RatingItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: 5,
      alignment: Alignment.center,
      child: Icon(
        _item.iconData,
        color: _item.isSelected ? activeColor : inactiveColor,
      ),
    );
  }
}
