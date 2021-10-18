import 'package:harmony/utilites/kdtree_implementation/node.dart';

class KDTree{
  Node? rootNode;

  KDTree({this.rootNode});




  factory KDTree.fromJson(Map<String, dynamic> treeData){
    if (treeData.isEmpty){
      return KDTree();
    }
    return KDTree(
      rootNode: createNode(treeData['root_node'])
    );
  }

  static Node createNode(Map<String, dynamic> nodeData){
    Node node = Node(
        point: nodeData['coordinate'] as List<double>
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



}