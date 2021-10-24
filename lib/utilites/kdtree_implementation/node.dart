class Node{

  Node? leftChild;
  Node? rightChild;


  List<double> point;
  String placeID;

  bool get isLeaf => (leftChild == null && rightChild == null);

  Node({required this.point, required this.placeID, this.leftChild, this.rightChild});

  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = {};
    json.addAll({
      'coordinate': [
        point[0].toDouble(),
        point[1].toDouble(),
        point[2].toDouble()
      ],
      'place_id' : placeID
    });
    if(rightChild != null){
      json.addAll(rightChild!.toJson());
    }
    if(leftChild != null){
      json.addAll(leftChild!.toJson());
    }
    return json;
  }

}