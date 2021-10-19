import 'package:harmony/utilites/kdtree_implementation/node.dart';

class KDTree{
  Node? rootNode;
  String str = "";

  KDTree({this.rootNode});




  factory KDTree.fromJson(Map<String, dynamic> treeData){
    if (treeData == null){
      return KDTree();
    }
    return KDTree(
      rootNode: createNode(treeData['root_node'])
    );
  }

  static List<double> parseCoordinate(List<dynamic> coord){
    List<double> coordDouble = [];
    for (dynamic coor in coord){
      int coorint = coor as int;
      double coordouble = coor.toDouble();
      coordDouble.add(coordouble);
    }
    return coordDouble;
  }
  static Node createNode(Map<String, dynamic> nodeData){
    Node node = Node(
        point: parseCoordinate(nodeData['coordinate']),
        placeID: nodeData['place_id'] as String
    );

    if (nodeData['left_child'] != null){
      Node leftChild = createNode(nodeData['left_child']);
      node.leftChild = leftChild;
    }
    if(nodeData["right_child"] != null){
      Node rightChild = createNode(nodeData["right_child"]);
      node.rightChild = rightChild;
    }

    return node;
  }


  void toStringTree(Node? node){
    if (node == null){
      return;
    };

    str += node.point.toString();
    //LEAF
    if (node.leftChild == null && node.rightChild == null) return;

    str += '(';
    toStringTree(node.leftChild);
    str+= ')';

    if(node.rightChild != null){
      str += '(';
      toStringTree(node.rightChild);
      str += ')';
    }


  }



}