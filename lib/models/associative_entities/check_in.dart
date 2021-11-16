import 'package:cloud_firestore/cloud_firestore.dart';

class CheckIn{
  Timestamp time;
  CheckIn(this.time);

  @override
  String toString(){
    return time.toString();
  }
}