import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';

class Place{
  final String id;
  PlaceCategory category;
  GeoFirePoint point;
  String name;
  List<dynamic> pastUserIds;
  List<dynamic> reviewIds;
  double rating;


  Place(this.id, this.category, this.point, this.name, this.pastUserIds,
      this.reviewIds, this.rating);

  ///FROM DB


  factory Place.fromJson(Map<String, dynamic> data, String id) {
    PlaceCategory parsePlaceCategory(String sPlaceCategory){
      return PlaceCategory.values.firstWhere((e) => e.toString() == sPlaceCategory); //from string to enum
    }
    GeoFirePoint parsePoint(Map<String, dynamic> point){
      GeoPoint geoPoint = point['geopoint'];
      return GeoFirePoint(geoPoint.latitude, geoPoint.longitude);
    }

    //TODO
    return Place(
      id,
      parsePlaceCategory(data["category"] as String),
      parsePoint(data['point']),
      data["name"] as String,
      data["past_user_ids"] as List<dynamic>,
      data['review_ids'] as List<dynamic>,
      (data["rating"] as int).toDouble(),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'category': category.toString(),
      'name': name,
      'point': point.data,
      'past_user_ids': pastUserIds,
      'review_ids': reviewIds,
      'rating': rating,
    };
  }

}