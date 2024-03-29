import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:harmony/models/associative_entities/check_in.dart';
import 'package:harmony/models/review.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/services/geo_fire.dart';
import 'package:harmony/utilites/custom_exception.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';


class FireStoreService {
  static CollectionReference users = FirebaseFirestore.instance.collection('users');
  static CollectionReference places = FirebaseFirestore.instance.collection('places');
  static CollectionReference reviews = FirebaseFirestore.instance.collection('reviews');
  static final GeoFireService _geoFireService = GeoFireService();

  String uploadPlaceImageToDatabase(File image, Place place){
    String firestoragePath = "places/${place.id}/cover";
    Reference storageRef = FirebaseStorage.instance.ref().child(firestoragePath);
    storageRef.putFile(image);
    return firestoragePath;
  }

  ///READS
  Future<List<Place>> getPlacesNearUser(LocationData userLocation, FilterModel filterModel) async {
    GeoFirePoint center = _geoFireService.createGeoPoint(userLocation.latitude!, userLocation.longitude!);
    String field = "point";
    Stream<List<DocumentSnapshot>> documentStream = _geoFireService.geo.collection(collectionRef: places).within(
      center: center, radius: filterModel.proximity, field: field
    );
    return await filterNearPlacesStream(documentStream, filterModel.chosenCategories, filterModel.minimumRating);
  }

  Future<List<Place>> filterNearPlacesStream(Stream<List<DocumentSnapshot>> documentStream, List<PlaceCategory> categoriesEligible, int rating) async{
    List<Place> nearPlaces = [];
    await for (List<DocumentSnapshot> documentList in documentStream){
      for(DocumentSnapshot doc in documentList){
        Place place = Place.fromJson(doc.data()! as Map<String, dynamic>, doc.id);
        if(isEligibleForNearPlace(place, categoriesEligible, rating)){
          nearPlaces.add(place);
        }
      }
      break; // due to a bug, this thing actually returns list so we are fine, but an absurt bug maks this for unable to break
    }
    return nearPlaces;
  }

  bool isEligibleForNearPlace(Place place, List<PlaceCategory> categoriesEligible, int rating){
    if (categoriesEligible.isNotEmpty && !(categoriesEligible.contains(place.category))){
      return false;
    }
    if(rating > place.rating && rating != 1) { //if its 1, than all places can be included
      return false;
    }
    return true;
  }

  Future<Place> addPlace(String name, PlaceCategory category, File imageFile, double latitude, double longitude) async{
    ///Returns id
    //ADDING TO FIREBASE
    GeoFirePoint geoPoint = _geoFireService.createGeoPoint(latitude, longitude);
    DocumentReference result = await places.add(
      {
        'category': category.toString(),
        'point': geoPoint.data,
        'name': name,
        'past_user_ids': [],//no users check in
        'review_ids': [],
        'rating': 0, // initial rating
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
          'check_in': <CheckIn>[]
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
    List<String> reviews = place.reviewIds as List<String>;
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


  Future<String> getCoverFromId(String placeId) async {
    Reference instance = FirebaseStorage.instance.ref("places/$placeId/cover");
    return await instance.getDownloadURL();
  }

  Future<Place> getPlaceFromId(String placeId) async {
    var place = await places.doc(placeId).get();
    return Place.fromJson(place.data() as Map<String, dynamic>, placeId);
  }

  Future<HarmonyUser> getUserFromId(String userId) async {
    var user = await users.doc(userId).get();
    return HarmonyUser.fromJson(user.data() as Map<String, dynamic>, userId);
  }

  Future<Review> getReviewFromId(String reviewId) async {
    var review = await reviews.doc(reviewId).get();
    return Review.fromJson(review.data() as Map<String, dynamic>, reviewId);
  }

  void removeFavoriteFromUser(String placeId, HarmonyUser user) {
    List<dynamic> favorites = user.favoritesID;
    favorites.remove(placeId);

    users.doc(user.id).get().then(
      (userDoc) {
        userDoc.reference.update(
          {
            "favorite_places": favorites
          }
        );
      }
    );
  }

  void addFavoriteToUser(String placeId, HarmonyUser user) {
    List<dynamic> favorites = user.favoritesID;
    favorites.add(placeId);

    users.doc(user.id).get().then(
      (userDoc) {
        userDoc.reference.update(
          {
            "favorite_places": favorites
          }
        );
      }
    );
  }

  Stream<TaskSnapshot> changePfpOfUser(HarmonyUser user, XFile file) {
    String firestoragePath = "users/${user.id}/pfp";
    Reference storageRef = FirebaseStorage.instance.ref().child(firestoragePath);
    UploadTask uploadTask = storageRef.putFile(File(file.path));
    return uploadTask.snapshotEvents;
  }

  Future<String> getPfpFromId(String userId) async {
    Reference instance = FirebaseStorage.instance.ref("users/$userId/pfp");
    return await instance.getDownloadURL();
  }

  Future<bool> anyPlaceExistWithHash(String geoHash) async{
    QuerySnapshot snapshot = await places.where(
      'point.geohash',
      isEqualTo: geoHash
    ).get();
    return snapshot.docs.isNotEmpty;
  }

  Future<Review> createReview(Map review, Place place, HarmonyUser user) async {
    DocumentSnapshot reviewSnapshot = await addReview(review);
    Map<String, dynamic> data = extractDataFromSnapshot(reviewSnapshot);
    updateReviewsOfPlace(place, reviewSnapshot);
    updateUserReviews(user, reviewSnapshot);

    return Review.fromJson(data, reviewSnapshot.id);
  }

  void updateUserReviews(HarmonyUser user, DocumentSnapshot<Object?> reviewSnapshot) {

    List<dynamic> userReviews = user.reviewIds;
    userReviews.add(reviewSnapshot.id);

    users.doc(user.id).get().then(
      (userDoc) {
        userDoc.reference.update(
          {
            "reviews": userReviews
          }
        );
      }
    );
  }

  Future<DocumentSnapshot> addReview(Map review) async {
    DocumentReference result = await reviews.add(
        Map<String, dynamic>.from(review)
    );

    return await result.get();
  }

  Map<String, dynamic> extractDataFromSnapshot(DocumentSnapshot reviewSnapshot){
    try{
      return reviewSnapshot.data() as Map<String, dynamic>;
    } catch(_){
      return {};
    }
  }

  void updateReviewsOfPlace(Place place, DocumentSnapshot reviewSnapshot){
    List<dynamic> placeReviews = place.reviewIds;
    placeReviews.add(reviewSnapshot.id);

    places.doc(place.id).get().then(
            (placeDoc) {
          placeDoc.reference.update(
              {
                "review_ids": placeReviews
              }
          );
        }
    );
  }

  void checkInUser(HarmonyUser user, Timestamp timestamp, Place place) {
    //CheckIn checkIn = CheckIn(Timestamp.now());
    CheckIn checkIn = CheckIn(timestamp);
    user.checkIns.add(checkIn);
    _checkInUserAtDB(user);
    _updatePlacePUIDS(place, user);
  }

  void _checkInUserAtDB(HarmonyUser user){
    users.doc(user.id).get().then(
            (userDoc){
          userDoc.reference.update(
            user.toJson()
          );
        }
    );
  }

  void _updatePlacePUIDS(Place place, HarmonyUser user) { // PUIDS stands for PastUserIds,
    List<HarmonyUser> pastUsers = place.pastUsers;
    pastUsers.add(user);

    places.doc(place.id).get().then(
      (placeDoc) {
        placeDoc.reference.update({
          "past_user_ids": pastUserIds
        });
      }
    );
  }

  void reviewLikedByUser(Review review, HarmonyUser user) {
    _handleLikeForReview(review, user);
  }

  void _handleLikeForReview(Review review, HarmonyUser user) {
    review.like(user);
    _updateReview(
      review,
      {
        "likes": review.getLikesAsString()
      }
    );
  }

  void _updateReview(Review review, Map<String, dynamic> fields) {
    reviews.doc(review.id).get().then(
      (reviewDoc) {
        reviewDoc.reference.update(
          fields
        );
      }
    );
  }

  void reviewUnlikedByUser(Review review, HarmonyUser user) {
    review.unlike(user);
    _updateReview(
        review,
        {
          "likes": review.getLikesAsString()
        }
    );
  }
}