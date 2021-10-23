import 'dart:async';

import 'package:flutter/material.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';
import 'package:harmony/widgets/filter/category_widgets/CategoryGridViewModel.dart';
import 'package:provider/provider.dart';

class CategoryGridItem extends StatefulWidget {
  final IconData icon; // imo use icondata, later on we can change initial color size etc. much easily
  final Function(CategoryGridItem) onTap;
  final StreamController deactivationStream;
  final PlaceCategory placeCategory;

  CategoryGridItem(this.icon, this.onTap, this.deactivationStream, this.placeCategory);

  @override
  _CategoryGridItemState createState() => _CategoryGridItemState();

}

class _CategoryGridItemState extends State<CategoryGridItem> {

  bool selected = false;
  Color activeColor = Color(0xFF5F5D70);
  Color inactiveColor = Color(0xffececec);

  void tapped(){
    setState(() {
      selected = !selected;
    });
    widget.onTap(
      widget,
    );
  }

  void someoneGotDisabled(dynamic event){
    try{
      event as CategoryGridItem;
      if(event == widget){ //This means that we are the disabled one
        disable();
      }
    } catch(e){
      //How did we even get here? will be called many times as an item but this execution is in theory impossible
      Navigator.pushReplacementNamed(
          context,
          kErrorPageRouteName);
    }
  }

  void disable(){
    setState(() {
      selected = false;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.deactivationStream.stream.listen(
      someoneGotDisabled
    );
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapped,
      child: Container(
          alignment: Alignment.center,
          child: Center(
            child: Icon(
              widget.icon,
              size: 15, // bkz line 4, for example
            ),
          ),
          color: selected ?  activeColor : inactiveColor,
        ),
    );
  }
}
