import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class GeoFireService{
  final geo = Geoflutterfire();
  final _firestore = FirebaseFirestore.instance;

  GeoFirePoint createGeoPoint(double latitude, double longitude){
    return geo.point(latitude: latitude, longitude: longitude);
  }

}