import 'dart:ffi';
import 'dart:math' as math;
import 'dart:ui';

import 'package:harmony/models/place.dart';
import 'package:harmony/utilites/custom_exception.dart';
import 'package:harmony/utilites/kdtree_implementation/kdtree.dart';
import 'package:harmony/services/firestore.dart';
import 'package:harmony/utilites/kdtree_implementation/node.dart';
//https://www.cs.cmu.edu/~ckingsf/bioinfo-lectures/kdtrees.pdf
class KDTreeService{

  static KDTree? tree; //I am actually not sure how to not make this nullable, find a solution if you can


  static void  initTree() async{
    tree = await FireStoreService().initKDTree();


    //TESTS
    addTestPlace([1,1,1]);
    addTestPlace([1,5,7]);
    addTestPlace([3,5,7]);
    addTestPlace([4,5,6]);
    addTestPlace([8,9,2]);
    addTestPlace([8,12,3]);
    addTestPlace([1,7,3]);
    addTestPlace([6,1,4]);
    addTestPlace([6,7,7]);
    addTestPlace([7,5,2]);
    addTestPlace([12,15,16]);
    addTestPlace([13,15,16]);
    addTestPlace([13,12,16]);
    addTestPlace([17,12,19]);
    addTestPlace([65,23,176]);
    addTestPlace([6135,131,14124]);
    addTestPlace([21213,123112,1231515]);
    addTestPlace([1,8,6]);


    tree!.toStringTree(tree!.rootNode);
    print(tree!.str);

    /*List<String> neighbours = KDTreeService().findNearPlaces(
        [3,3,3],
        3
    );*/
    List<String> neighbours = KDTreeService().findNearPlaces(
        [2,7,7],
        5
    );

    print(neighbours);


  }
  static void addTestPlace(List<double> coord){
    List<Image> dummyImage = [];
    List<String> dummyStringarr = [];
   KDTreeService().insertPosition(
        Place(coord.toString(), "category", coord, "description", dummyImage, "name", dummyStringarr, 1, dummyStringarr)
    );
  }

  void insertPosition(Place place){
    ///Requires a Cartesian Coordinate, an x,y coordinate
    ///May be time expensive, wait for it
    if(place.coordinate.length != 3){
      throw new CustomException("Cartesian Coordinate list must include 3 vars, x,y,z");
    }
    try{
      tree!.rootNode = _insert(place, tree!.rootNode);
    } catch(e){
        print(e.toString());
    }
  }

  void deletePosition(Place place){
    ///Requires a Cartesian Coordinate, an x,y coordinate
    ///May be time expensive, wait for it
    List<double> cartesianCoordinate = place.coordinate;
    if(cartesianCoordinate.length != 3){
      throw new CustomException("Cartesian Coordinate list must include 3 vars, x,y,z");
    }
    try{
      tree!.rootNode = _delete(cartesianCoordinate, tree!.rootNode, 3);
    } catch(e){
      print(e.toString());
    }
  }




  Node _insert(Place place, Node? node, {int cd : 0}){
    List<double> point = place.coordinate;
    int k = point.length;
    if (node == null) {
      node = Node(
          point: point,
        placeID: place.id
      );
    }
    else if(point == node.point){
      return throw new CustomException("Duplicate Node!");
    }
    else if(point[cd] < node.point[cd]) {
      node.leftChild = _insert(place, node.leftChild, cd : (cd+1) % k);
    }
    else {
      node.rightChild = _insert(place, node.rightChild, cd : (cd+1) % k);
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

  List<String> findNearPlaces(List<double> cartesianCoordinate, int distance){
    ///First argument is the users place or the coordinate relative to distance, second arg is distance in km ex(1)
    ///Returns place ids
    List<String> neighbours = [];
    int itemsvisited = 0;

    void _findFixedRadiusNeighbours(Node? T, List<double> x, int cd, int dist){
      ///T -> tree, x -> desired loc, cd -> depth and dim, dist -> in km
      int next_cd = (cd+1) % x.length;
      if (T == null){
        return;
      }
      itemsvisited++;

      if(x[cd] < T.point[cd]){ //Left tree

        //Then check the left subtree
        //After, check if query search point of right subtree is nearer than 1km to loc, if is search right subtree too
         _findFixedRadiusNeighbours(T.leftChild, x, next_cd, dist);
        if (_isInBoundingBoxDist(x, T, cd, dist)){
          _findFixedRadiusNeighbours(T.rightChild, x, next_cd, dist);
        }
        if(_distance(x, T.point) <= dist) neighbours.add(T.placeID); //check distance of parent node

      }else { //equal or bigger
        //vice versa
        _findFixedRadiusNeighbours(T.rightChild, x, next_cd, dist);
        if (_isInBoundingBoxDist(x, T, cd, dist)){
          _findFixedRadiusNeighbours(T.leftChild, x, next_cd, dist);
        }
        if(_distance(x, T.point) <= dist) neighbours.add(T.placeID);
      }
    }
    _findFixedRadiusNeighbours(tree!.rootNode, cartesianCoordinate, 0, distance);
    print("visited " + itemsvisited.toString() + " items");
    return neighbours;

  }





  int _distance(List<double> coord1, List<double> coord2 ){
    double distanceSquared = 0;
    for(int i = 0; i < coord1.length ; i++){
      distanceSquared += math.pow((coord1[i] - coord2[i]), 2); // (x1- x2) squared
    }
    return math.sqrt(distanceSquared).round();

  }

  bool _isInBoundingBoxDist(List<double> x, Node? T, int cd, int dist){
    //By this way, you have all axes same instead of cd, thats really what we want
    // you want to compare only the axis you are on, thats why you change that on line 228
    //also while calling this function it takes the next cd, thats because you index child nodes depending on the next cd i.e axis. Reason is that this function is called from the parent!
    if(T == null) return false;

    if( ((x[cd] - T.point[cd])).abs()  <= dist){
      return true;
    }
    return false;

  }






}