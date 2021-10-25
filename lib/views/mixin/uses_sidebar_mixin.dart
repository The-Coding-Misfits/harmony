import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsesSideBar{

  IconButton onMenuCallback(Function() onPress){
    return IconButton(
      onPressed: onPress,
      icon: const Icon(
        Icons.menu,
        size: 25,
      ),
    );
  }

}