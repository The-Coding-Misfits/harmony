//didnt include in viewmodel directory in top because it is just for category grid, could too whatever

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';

import 'CategoryGridItem.dart';

class CategoryGridViewModel extends ChangeNotifier{

  bool _isSingularChoice;
  List<CategoryGridItem> _items = []; // init later
  StreamController deactivationStream = new StreamController.broadcast();

  CategoryGridItem? _currSelectedItem;
  PlaceCategory? currSelectedCategory;



  CategoryGridViewModel(this._isSingularChoice){
    _items =
  }






  void tapped(CategoryGridItem tappedItem){ // the item that is tapped
    if(tappedItem == _currSelectedItem!){ //Means this was the selected and now its disabled
      _currSelectedItem = null;
      currSelectedCategory = null;
    } else {
      _deactivationStream.add(_currSelectedItem); //we deactivate this item, well it would be awesome to just call a function but we should not touch state from Stateful widget class, which kinda fckn sucks
      _currSelectedItem = tappedItem;
      currSelectedCategory = tappedItem.placeCategory;
    }

  }



}