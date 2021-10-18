import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harmony/utilites/custom_exception.dart';
import 'package:harmony/utilites/kdtree_implementation/kdtree.dart';
import 'package:harmony/services/firestore.dart';
import 'package:harmony/utilites/kdtree_implementation/node.dart';
//https://www.cs.cmu.edu/~ckingsf/bioinfo-lectures/kdtrees.pdf
class KDTreeService{

  static KDTree? tree; //I am actually not sure how to not make this nullable, find a solution if you can


  static void  initTree() async{
    tree = await FireStoreService().initKDTree();

    KDTreeService().insertPosition([1,1,3]);
  }

  void insertPosition(List<double> cartesianCoordinate){
    ///Requires a Cartesian Coordinate, an x,y coordinate
    ///May be time expensive, wait for it
    if(cartesianCoordinate.length != 2){
      throw new CustomException("Cartesian Coordinate list must include 2 vars, x,y");
    }
    try{
      tree!.rootNode = _insert(cartesianCoordinate, tree!.rootNode);
    } catch(e){
        print(e.toString());
    }
  }

  void deletePosition(List<double> cartesianCoordinate){
    ///Requires a Cartesian Coordinate, an x,y coordinate
    ///May be time expensive, wait for it
    if(cartesianCoordinate.length != 2){
      throw new CustomException("Cartesian Coordinate list must include 2 vars, x,y");
    }
    try{
      tree!.rootNode = _delete(cartesianCoordinate, tree!.rootNode, 2);
    } catch(e){
      print(e.toString());
    }
  }




  Node _insert(List<double> point, Node? node, {int cd : 0}){
    int k = point.length;
    if (node == null) {
      node = Node(point: point);
    }
    else if(point == node.point){
      return throw new CustomException("Duplicate Node!");
    }
    else if(point[cd] < node.point[cd]) {
      node.leftChild = _insert(point, node.leftChild, cd : (cd+1) % k);
    }
    else {
      node.rightChild = _insert(point, node.rightChild, cd : (cd+1) % k);
    }
    return node;
  }

  List<double> _findmin(Node? T, int dim, int cd){
    if (T == null) return throw new CustomException("Empty tree!"); //empty tree

    // T splits on the dimension we’re searching
    // => only visit left subtree
    if (cd == dim){
      if (T.leftChild == null) return T.point; //Smallest in this subtree
      else return _findmin(T.leftChild, dim, (cd+1) % dim);
    }

    // T splits on a different dimension
    // => have to search both subtrees
    else {
      List<List<double>> list = [
        _findmin(T.leftChild, dim, (cd+1) % dim),
        _findmin(T.leftChild, dim, (cd+1) % dim),
        T.point
      ];
      list.sort((a,b) => a[dim].compareTo(b[dim])); //find min of dimension
      return list[0];
    }
  }

  Node? _delete(List<double> x, Node? T,int dim, {int cd : 0}){
    if (T == null) return throw new CustomException("Empty tree!");
    int next_cd = (cd+1) % dim;

    // This is the point to delete:
    if(x == T.point){
      // use min(cd) from right subtree:
      if(T.rightChild != null){
        //Basically switch
        T.point = _findmin(T.rightChild, dim, next_cd);
        T.rightChild = _delete(T.point, T.rightChild, dim, cd: next_cd);
      }
      else if(T.leftChild != null){ // swap subtrees and use min(cd) from new right:
        T.point = _findmin(T.leftChild, dim, next_cd);
        T.leftChild = _delete(T.point, T.leftChild, dim , cd: next_cd);
      }
      else{
        T = null; // we’re a leaf: just remove
      }
    }
    // this is not the point, so search for it:
    else if(x[cd] < T.point[cd]){
      T.leftChild = _delete(x, T.leftChild, dim , cd: next_cd);
    }
    else {
      T.rightChild = _delete(x, T.rightChild, dim , cd: next_cd);
    }
    return T;
  }

  Node balanceTree(){

  }

}