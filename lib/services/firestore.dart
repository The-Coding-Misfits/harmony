
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:harmony/models/review.dart';
import 'package:harmony/models/user.dart';
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

  ///These deletes are called from outside


  //PLACE DELETING
  Future<bool> deletePlace(Place place) async {
    ///Returns whether successfully deleted





  }



  //ACCOUNT DELETING
  Future<bool> deleteAccount(HarmonyUser user) async {
    ///Returns whether successfully deleted


  }


  //REVIEW DELETING
  Future<bool> deleteReview(Review review) async {
    ///Returns whether successfully deleted


  }


  //for deleting documents!
  Future<bool> _deleteDBObjectDoc(Type objectType, String id) async {

    //delete method throws error if cannot delete
    try{
      if(objectType == HarmonyUser){
        await users.doc(id).delete();
      } else if(objectType == Place){
        await places.doc(id).delete();
      } else if (objectType == Review){
        await reviews.doc(id).delete();
      }
      else {
        return false;
      }
      return true;
    } catch (e){
      return false;
    }
  }




  Future<List<Reference>> imageUrlsPlace(String id) async{
    ListResult result =  await FirebaseStorage.instance.ref().child(id).listAll();
    return result.items;
  }

  void updateKDTree(KDTree tree){
    place_kdtree.doc('TREE').update(tree.toJson());
  }



}