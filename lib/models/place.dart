import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harmony/models/review.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';

class Place{
  final String id;
  PlaceCategory category;
  List<double> coordinate; //Requires cartesian coordinates
  String description;
  List<Image> images;
  String name;
  List<String> _pastUserIds;
  int rating;
  List<String> _reviewsIds;


  Place(this.id, this.category, this.coordinate, this.description, this.images,
      this.name, this._pastUserIds, this.rating, this._reviewsIds);

  factory Place.fromJson(Map<String, dynamic> data){

    List<Image> parseImages(dynamic imagePathArray){
      List<DocumentReference> references= imagePathArray;
      print(references.toString());
      List<Image> images = [];
      for(DocumentReference reference in references){
        //TODO
        //Figure getting snaphsot first
      }
      return images;
    }
    PlaceCategory parsePlaceCategory(String sPlaceCategory){
      return PlaceCategory.values.firstWhere((e) => e.toString() == sPlaceCategory); //from string to enum
    }

    //TODO
    return Place(
      data["id"] as String,
      parsePlaceCategory(data["category"] as String),
      data["coordinate"] as List<double>,
      data["description"] as String,
      parseImages(data["imagePaths"]),
      data["name"] as String,
      data["pastUsers"] as List<String>,
      data["rating"] as int,
      data["review"] as List<String>,
    );
  }

  List<Review> getReviews(){
    return _reviewsIds.map((id) => Review.findFromID(id)) as List<Review>;
  }

  List<HarmonyUser> getPastUsers(){
    return _pastUserIds.map((id) => HarmonyUser.findUserFromID(id)) as List<HarmonyUser>;
  }


  ///Class stuff
  static Map<String, Place> places = {};
  static Place findFromID(String id){
    Place? place = places[id];
    if(place == null){
      return throw("No place exists with this id!");
    }
    return place;
  }
}