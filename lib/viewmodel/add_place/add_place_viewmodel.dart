import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:harmony/models/place.dart';
import 'package:harmony/services/firestore.dart';
import 'package:harmony/services/kdtree_service.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';

class AddPlaceViewModel{

  void createPlace(String name, PlaceCategory category, File imageFile, List<double> coordinates) async{
    String id = await FireStoreService().addPlace(name, category, imageFile, coordinates);

    Place newPlace = Place(
        id,
        category,
        coordinates,
        [convertFileToImage(imageFile)], //init with first image as cover
        name,
        [],
        0,
        []);
    _addToPlaceKDTree(newPlace);
    FireStoreService().uploadPlaceImageToDatabase(imageFile, newPlace);
  }

  Image convertFileToImage(File picture) {
    List<int> imageBase64 = picture.readAsBytesSync();
    String imageAsString = base64Encode(imageBase64);
    Uint8List uint8list = base64.decode(imageAsString);
    Image image = Image.memory(uint8list);
    return image;
  }

  void _addToPlaceKDTree(Place place){
    KDTreeService().insertPosition(place);
    FireStoreService().updateKDTree(KDTreeService.tree!);
  }

}