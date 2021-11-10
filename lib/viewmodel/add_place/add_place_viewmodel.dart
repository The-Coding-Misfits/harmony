import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/services/firestore.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';

class AddPlaceViewModel{

  createPlace(String name, PlaceCategory category, File imageFile, double latitude, double longitude) async {
    FireStoreService fireStoreService = FireStoreService();

    try {
      Place newPlace = await fireStoreService.addPlace(name, category, imageFile, latitude, longitude);
      fireStoreService.uploadPlaceImageToDatabase(imageFile, newPlace);
      return newPlace;
    } on FileSystemException {
      return 500;
    } on FirebaseException {
      return 500;
    }
  }

  Image convertFileToImage(File picture) {
    List<int> imageBase64 = picture.readAsBytesSync();
    String imageAsString = base64Encode(imageBase64);
    Uint8List uint8list = base64.decode(imageAsString);
    Image image = Image.memory(uint8list);
    return image;
  }


}