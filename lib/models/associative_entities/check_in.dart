import 'package:cloud_firestore/cloud_firestore.dart';

class CheckIn implements Comparable{
  Timestamp time;
  CheckIn(this.time);

  @override
  String toString(){
    return time.toString();
  }

  @override
  int compareTo(other) {
    other as CheckIn;
    return time.compareTo(other.time);
  }
}