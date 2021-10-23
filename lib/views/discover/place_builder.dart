import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:harmony/services/firestore.dart';

class PlaceBuilder extends StatefulWidget {
  const PlaceBuilder({Key? key}) : super(key: key);

  @override
  _PlaceBuilderState createState() => _PlaceBuilderState();
}

class _PlaceBuilderState extends State<PlaceBuilder> {

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemBuilder: (BuildContext context, int index){
        return Container();
      },
    );
  }


}
