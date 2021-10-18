import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harmony/utilites/kdtree_implementation/kdtree.dart';
import 'package:harmony/utilites/kdtree_implementation/kdtree.dart';
import 'package:harmony/models/place.dart';

class FireStoreService{
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static CollectionReference users = FirebaseFirestore.instance.collection('users');
  static CollectionReference places = FirebaseFirestore.instance.collection('places');
  static CollectionReference reviews = FirebaseFirestore.instance.collection('reviews');
  static CollectionReference place_kdtree = FirebaseFirestore.instance.collection("place-kdtree");

  Future<KDTree> initKDTree() async{
    return await place_kdtree.
    doc("TREE").
    get().
    then(
            (value) => KDTree.fromJson(value.data()! as Map<String, dynamic>)
    );
  }

  Stream<QuerySnapshot> getPlacesStream(){
    return places.snapshots();
  }





  void addPlace(){
    //IMPLEMENTATION AND SO WHAT
    //Add to place kd tree for optimization
    ///addToPlaceKDTree();
  }

  void addToPlaceKDTree(Place place){
    //TODO
  }

}