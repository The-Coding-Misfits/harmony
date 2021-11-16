import 'package:cloud_firestore/cloud_firestore.dart';

class Review{
  final String authorID;
  final String placeID;
  final String id;
  String content;
  int likes;
  int rating;
  DateTime timeAdded;

  Review(this.authorID, this.id, this.content, this.likes, this.rating, this.timeAdded, this.placeID);

  factory Review.fromJson(Map<String, dynamic> data, String id){

    DateTime parseTimestamp(dynamic timeAdded){ //parse dynamic timestamp from firestore to datetime
      Timestamp t = timeAdded; //built-in timestamp class firestore
      return t.toDate();
    }

    return Review(
      data["authorId"] as String,
      id,
      data["content"] as String,
      data["likes"] as int,
      data["rating"] as int,
      parseTimestamp(data["timeAdded"]),
      data['placeId'] as String,
    );

  }


  Map<String, dynamic> toJson(){
    return {
      'author_id': authorID,
      'content': content,
      'likes': likes,
      'rating': rating,
      'time_added': Timestamp.fromDate(timeAdded),
      'place_id': placeID
    };
  }
}


