import 'package:harmony/models/review.dart';
import 'package:harmony/models/place.dart';
class HarmonyUser{
  final String id; // Not designated by us as all other classes, comes from firestore when creating document
  String username;//May change in profile settings etc.
  List<String> _pastPlaceIDs;
  List<String> _reviewIds;


  HarmonyUser(this.id, this.username,
      this._pastPlaceIDs, this._reviewIds);

  factory HarmonyUser.fromJson(Map<String, dynamic> data){
    return HarmonyUser(
      data["id"] as String,
      data["username"] as String,
      data["past_places"] as List<String>,
      data["reviews"] as List<String>
    );
  }

  List<Review> getReviews(){
    return _reviewIds.map((id) => Review.findFromID(id)) as List<Review>;
  }

  List<Place> getPastPlaces(){
    return _pastPlaceIDs.map((id) => Place.findFromID(id)) as List<Place>;
  }

  ///NOT BEST PRACTICE BUT WHO CARES
  static Map<String, HarmonyUser> users = {}; //Hash map, constant lookup n'stuff
  static HarmonyUser findUserFromID(String id){
    HarmonyUser? user = users[id];
    if(user == null){
      return throw("No user exists with this id!");
    }
    return user;
  }
}