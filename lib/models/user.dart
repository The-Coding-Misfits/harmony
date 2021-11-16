
import 'package:cloud_firestore/cloud_firestore.dart';

import 'associative_entities/check_in.dart';

class HarmonyUser{
  final String id; // Not designated by us as all other classes, comes from firestore when creating document
  final String uid;
  String username;//May change in profile settings etc.
  List<dynamic> reviewIds;
  List<dynamic> favoritesID;
  List<CheckIn> checkIns;


  HarmonyUser(this.id, this.uid, this.username, this.reviewIds,
      this.favoritesID, this.checkIns);

  factory HarmonyUser.fromJson(Map<String, dynamic> data, String id){
    return HarmonyUser(
      id,
      data["uid"] as String,
      data["username"] as String,
      data["reviews"] as List<dynamic>,
      data['favorite_places'] as List<dynamic>,
      _parseCheckIns(data['check_in']),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'favorite_places': favoritesID,
      'reviews': reviewIds,
      'username': username,
      'check_in': _convertCheckInsToString()
    };
  }

  List<String> _convertCheckInsToString(){
    List<String> checkInStringArray = [];
    for (CheckIn checkIn in checkIns){
      checkInStringArray.add(checkIn.toString());
    }
    return checkInStringArray;
  }
  static List<CheckIn> _parseCheckIns(List<dynamic> rawCheckInArray){
    List<CheckIn> checkIns = [];
    for (dynamic timeStamp in rawCheckInArray){
      try{
        timeStamp as Timestamp;
      } catch(_){}
      checkIns.add(
        CheckIn(timeStamp)
      );
    }
    return checkIns;
  }
}