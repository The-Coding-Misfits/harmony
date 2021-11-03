import 'package:harmony/models/review.dart';
import 'package:harmony/models/place.dart';
class HarmonyUser{
  final String id; // Not designated by us as all other classes, comes from firestore when creating document
  final String uid;
  String username;//May change in profile settings etc.
  List<dynamic> reviewIds;
  List<dynamic> favoritesID;
  int checkIn;


  HarmonyUser(this.id, this.uid, this.username, this.reviewIds,
      this.favoritesID, this.checkIn);

  factory HarmonyUser.fromJson(Map<String, dynamic> data, String id){
    return HarmonyUser(
      id,
      data["uid"] as String,
      data["username"] as String,
      data["reviews"] as List<dynamic>,
      data['favorite_places'] as List<dynamic>,
      data['check_in'] as int,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'favorite_places': favoritesID,
      'reviews': reviewIds,
      'username': username,
      'check_in': checkIn
    };
  }

}