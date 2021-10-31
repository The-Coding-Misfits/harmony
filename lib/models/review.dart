import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harmony/models/user.dart';

class Review{
  final String _authorID;
  final String id;
  String content;
  int likes;
  int rating;
  DateTime timeAdded;

  Review(this._authorID, this.id, this.content, this.likes, this.rating, this.timeAdded);

  factory Review.fromJson(Map<String, dynamic> data){

    DateTime parseTimestamp(dynamic timeAdded){ //parse dynamic timestamp from firestore to datetime
      Timestamp t = timeAdded; //built-in timestamp class firestore
      return t.toDate();
    }

    return Review(
      data["authorID"] as String,
      data["id"] as String,
      data["content"] as String,
      data["likes"] as int,
      data["rating"] as int,
      parseTimestamp(data["timeAdded"]),
    );

  }


  Map<String, dynamic> toJson(){
    return {
      'authorId': _authorID,
      'content': content,
      'likes': likes,
      'rating': rating,
      'timeAdded': Timestamp.fromDate(timeAdded),
    };
  }
}


