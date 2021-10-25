
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:harmony/services/kdtree_service.dart';
import 'package:harmony/utilites/custom_exception.dart';
import 'package:harmony/utilites/kdtree_implementation/kdtree.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';
import 'package:path/path.dart';



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

  String uploadPlaceImageToDatabase(File image, Place place){
    image.renameSync(DateTime.now().millisecondsSinceEpoch.toString());
    String firestoragePath = place.id + "/" + basename(image.path);
    Reference storageRef =
        FirebaseStorage.instance.ref().child(firestoragePath);
    storageRef.putFile(image);
    return firestoragePath;
  }



  Future<String> addPlace(String name, PlaceCategory category, File imageFile, List<double> coordinates) async{
    ///Returns id
    //ADDING TO FIREBASE
    dynamic result = await places.add(
      {
        'category' : category.toString(),
        'coordinate': [
          coordinates[0].toInt(),
          coordinates[1].toInt(),
          coordinates[2].toInt()
        ],
        'name' : name,
        'pastUserIds' : [],
        'rating' : 0,
        'reviewIds' : []
      });
    return result.id;
  }

  Future<List<Reference>> imageUrlsPlace(String id) async{
    ListResult result =  await FirebaseStorage.instance.ref().child(id).listAll();
    return result.items;
  }

  void updateKDTree(KDTree tree){
    place_kdtree.doc('TREE').update(tree.toJson());
  }



}