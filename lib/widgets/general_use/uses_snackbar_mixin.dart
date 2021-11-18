import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class UsesSnackbar{
  void showSnackbar(String message, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))
    );
  }
}