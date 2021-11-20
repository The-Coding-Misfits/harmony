import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harmony/models/associative_entities/like.dart';
import 'package:harmony/models/user.dart';

class Review{
  final String authorID;
  final String placeID;
  final String id;
  String content;
  List<Like> likes;
  int rating;
  DateTime timeAdded;

  Review(this.authorID, this.id, this.content, this.likes, this.rating, this.timeAdded, this.placeID);

  factory Review.fromJson(Map<String, dynamic> data, String id){

    DateTime parseTimestamp(dynamic timeAdded){ //parse dynamic timestamp from firestore to datetime
      Timestamp t = timeAdded; //built-in timestamp class firestore
      return t.toDate();
    }
    
    List<Like> parseLikes(dynamic rawLikes){
      List<Like> likes = [];
      try{
        List<String> likesAsUserIds = rawLikes as List<String>;
        for(String userId in likesAsUserIds){
          likes.add(Like(userId));
        }
        return likes;
      }catch(_){return [];}
    }

    return Review(
      data["authorId"] as String,
      id,
      data["content"] as String,
      parseLikes(data['reviews']),
      data["rating"] as int,
      parseTimestamp(data["timeAdded"]),
      data['placeId'] as String,
    );

  }

  int getLikeCount(){
    return likes.length;
  }

  void like(HarmonyUser userLiked){
    likes.add(
      Like(userLiked.id)
    );
  }

  Iterable<String> likesAsString(){
    return likes.map((e) => e.toString());
  }


  Map<String, dynamic> toJson(){
    return {
      'author_id': authorID,
      'content': content,
      'likes': likesAsString,
      'rating': rating,
      'time_added': Timestamp.fromDate(timeAdded),
      'place_id': placeID
    };
  }
}


