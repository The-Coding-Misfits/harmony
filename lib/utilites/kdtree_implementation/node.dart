import 'package:harmony/models/place.dart';

class Node{

  Node? leftChild;
  Node? rightChild;


  List<double> point;
  String placeID;

  bool get isLeaf => (leftChild == null && rightChild == null);

  Node({required this.point, required this.placeID, this.leftChild, this.rightChild});

}