import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:harmony/models/review.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/utilites/custom_exception.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';
import 'package:path/path.dart';



class FireStoreService{

  static CollectionReference users = FirebaseFirestore.instance.collection('users');
  static CollectionReference places = FirebaseFirestore.instance.collection('places');
  static CollectionReference reviews = FirebaseFirestore.instance.collection('reviews');


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



  Future<Place> addPlace(String name, PlaceCategory category, File imageFile, List<double> coordinates) async{
    ///Returns id
    //ADDING TO FIREBASE
    DocumentReference result = await places.add(
      {
        'category' : category.toString(),
        'coordinate': [
          coordinates[0].toInt(),
          coordinates[1].toInt(),
          coordinates[2].toInt()
        ],
        'name' : name,
        'past_user_ids' : [],
        'rating' : 0,
        'review_ids' : []
      });
    DocumentSnapshot placeSnapshot = await result.get();
    Map<String, dynamic> data = placeSnapshot.data() as Map<String, dynamic>;
    Place newPlace = Place.fromJson(data, placeSnapshot.id);
    return newPlace ;
  }

  Future<HarmonyUser> createUser(String uid, String username) async{
    DocumentReference result = await users.add(
        {
          'favorite_places' : [],
          'reviews' : [],
          'uid' : uid,
          'username' : username,
          'check_in': 0
        });
    DocumentSnapshot userSnapshot = await result.get();
    Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
    return HarmonyUser.fromJson(data, userSnapshot.id);
  }

  ///These deletes are called from outside

  //PLACE DELETING
  Future<void> deletePlace(Place place) async {
    ///Returns whether successfully deleted
    _deletePlaceFromFavorites(place.id);
    for(String reviewId in place.reviewIds){
      deleteReview(reviewId, deleteFromPlaceToo: false);
    }
    await places.doc(place.id).delete();
  }

  
  void _deletePlaceFromFavorites(String placeID){
    users.where(
        'favorite_places', arrayContains: placeID
    ).get().then((userDoc){
        for( DocumentSnapshot userSnapshot in userDoc.docs){
          _gotUserDocFavoritePlace(userSnapshot, placeID);
        }
    });
  }

  void _gotUserDocFavoritePlace(DocumentSnapshot userSnapshot, String placeID){
    Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
    List<String> favorites = data['favorite_places'];
    favorites.remove(placeID);
    userSnapshot.reference.update(
        {
          'favorite_places': favorites
        }
    );
  }



  //ACCOUNT DELETING
  Future<void> deleteAccount(HarmonyUser user) async {
    ///Returns whether successfully deleted
    //not sure if we gonna do this
    throw UnimplementedError();
  }


  //REVIEW DELETING
  Future<void> deleteReview(String reviewId, {bool deleteFromPlaceToo = true}) async { //delete from place is because when i delete place i dont want to update place again and again for every comment
    ///Returns whether successfully deleted
    _deleteReviewFromUser(reviewId);
    if(deleteFromPlaceToo) _deleteReviewFromPlace(reviewId);
    await reviews.doc(reviewId).delete();

  }


  void _deleteReviewFromUser(String reviewId){
    reviews.doc(reviewId).get().then(
            (reviewDoc){
          Review review = Review.fromJson(reviewDoc.data() as Map<String, dynamic>, reviewDoc.id);
          users.doc(review.authorID).get().then(
                  (userDoc){
                _gotUserDocReview(userDoc, reviewId);
              }
          );
        }
    );
  }

  void _gotUserDocReview(DocumentSnapshot userSnapshot, String reviewId){
    HarmonyUser user = HarmonyUser.fromJson(userSnapshot.data() as Map<String, dynamic>, userSnapshot.id);
    List<dynamic> reviews = user.reviewIds;
    reviews.remove(reviewId);
    userSnapshot.reference.update(
        {
          'reviews': reviews
        }
    );
  }

  void _deleteReviewFromPlace(String reviewId){
    reviews.doc(reviewId).get().then(
            (reviewDoc){
          Review review = Review.fromJson(reviewDoc.data() as Map<String, dynamic>, reviewDoc.id);
          places.doc(review.placeID).get().then(
                  (placeDoc){
                _gotPlaceReview(placeDoc, reviewId);
              }
          );
        }
    );
  }

  void _gotPlaceReview(DocumentSnapshot placeSnapshot, String reviewId) {
    Place place = Place.fromJson(
        placeSnapshot.data() as Map<String, dynamic>, placeSnapshot.id);
    List<String> reviews = place.reviewIds;
    reviews.remove(reviewId);
    placeSnapshot.reference.update(
      {
        'review_ids' : reviews
      }
    );
  }

  Future<List<Reference>> imageUrlsPlace(String id) async{
    ListResult result =  await FirebaseStorage.instance.ref().child(id).listAll();
    return result.items;
  }

  Future<HarmonyUser> getUserFromUID(String uid) async{
    QuerySnapshot snapshot = await users.where(
      'uid', isEqualTo: uid
    ).get();
    if(snapshot.docs.isNotEmpty){
      return HarmonyUser.fromJson(
        snapshot.docs.first.data() as Map<String, dynamic>, snapshot.docs.first.id
      );
    }else{
      return throw CustomException("No account exists like this!");
    }
  }

}