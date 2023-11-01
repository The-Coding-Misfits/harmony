import 'package:harmony/models/review.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class Place {
  final String id;
  final PlaceCategory category;
  final GeoFirePoint point;
  final String name;
  final List<HarmonyUser> pastUsers;
  final List<Review> reviews;
  final double rating;

  Place({
    required this.id,
    required this.category,
    required this.point,
    required this.name,
    required this.pastUsers,
    required this.reviews,
    required this.rating
  });

  factory Place.fromJson(Map<String, dynamic> data, String id) {
    GeoFirePoint parsePoint(Map<String, dynamic> point){
      GeoPoint geoPoint = point['geopoint'];
      return GeoFirePoint(geoPoint.latitude, geoPoint.longitude);
    }

    return Place(
      id: id,
      category: PlaceCategory.values.byName(data["category"]),
      point: parsePoint(data['point']),
      name: data["name"],
      pastUsers: data["pastUsers"], // TODO
      reviews: data["reviews"], // TODO
      rating: data["rating"],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "category": category.toString(),
      "name": name,
      "point": point,
      "pastUsers": pastUsers,
      "reviews": reviews,
      "rating": rating,
    };
  }
}