import 'package:harmony/models/review.dart';
import 'package:harmony/models/place.dart';
class HarmonyUser{
  final String id; // Not designated by us as all other classes, comes from firestore when creating document
  String username;//May change in profile settings etc.
  List<String> _reviewIds;
  List<String> _favoritesID;


  HarmonyUser(this.id, this.username,
      this._reviewIds, this._favoritesID);

  factory HarmonyUser.fromJson(Map<String, dynamic> data){
    return HarmonyUser(
      data["id"] as String,
      data["username"] as String,
      data["reviews"] as List<String>,
      data['favorite_places'] as List<String>
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'favorite_places': _favoritesID,
      'reviews': _reviewIds,
      'username': username,
    };
  }

}