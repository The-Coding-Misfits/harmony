import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference places = FirebaseFirestore.instance.collection('places');
  CollectionReference reviews = FirebaseFirestore.instance.collection('reviews');

  Stream<QuerySnapshot> getPlacesStream(){
    return places.snapshots();
  }


}