import 'package:harmony/utilites/places/place_category_enum.dart';

class Place{
  final String id;
  PlaceCategory category;
  List<double> coordinate; //Requires cartesian coordinates
  String name;
  List<String> pastUserIds;
  int rating;

  ///FROM DB
  Place(this.id, this.category, this.coordinate,
      this.name, this.pastUserIds, this.rating);

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
      data["past_user_ids"] as List<String>,
      data["rating"] as int,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'category': category.toString(),
      'coordinate': coordinate,
      'name': name,
      'past_user_ids': pastUserIds,
      'rating': rating,
    };
  }

}