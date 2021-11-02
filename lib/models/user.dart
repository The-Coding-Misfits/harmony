import 'package:harmony/models/review.dart';
import 'package:harmony/models/place.dart';
class HarmonyUser{
  final String id; // Not designated by us as all other classes, comes from firestore when creating document
  final String uid;
  String username;//May change in profile settings etc.
  List<String> reviewIds;
  List<String> favoritesID;


  HarmonyUser(
      this.id, this.uid, this.username, this.reviewIds, this.favoritesID);

  factory HarmonyUser.fromJson(Map<String, dynamic> data){
    return HarmonyUser(
      data["id"] as String,
      data["uid"] as String,
      data["username"] as String,
      data["reviews"] as List<String>,
      data['favorite_places'] as List<String>
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'favorite_places': favoritesID,
      'reviews': reviewIds,
      'username': username,
    };
  }

}