import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harmony/models/review.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';

class Place{
  final String id;
  PlaceCategory category;
  List<double> coordinate; //Requires cartesian coordinates
  String name;
  List<String> pastUserIds;
  int rating;
  List<String> reviewsIds;

  ///FROM DB
  Place(this.id, this.category, this.coordinate,
      this.name, this.pastUserIds, this.rating, this.reviewsIds);

  factory Place.fromJson(String id, Map<String, dynamic> data) {



    PlaceCategory parsePlaceCategory(String sPlaceCategory){
      return PlaceCategory.values.firstWhere((e) => e.toString() == sPlaceCategory); //from string to enum
    }
    //TODO
    return Place(
      id,
      parsePlaceCategory(data["category"] as String),
      data["coordinate"] as List<double>,
      data["name"] as String,
      data["pastUserIds"] as List<String>,
      data["rating"] as int,
      data["reviewIds"] as List<String>,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'category': category.toString(),
      'coordinate': coordinate,
      'name': name,
      'pastUserIds': pastUserIds,
      'rating': rating,
      'reviewIds' : reviewsIds
    };
  }

}