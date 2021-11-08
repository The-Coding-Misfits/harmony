import 'package:vector_math/vector_math.dart';
import 'dart:math';

double calculateDistanceBetweenTwoPoints(double lon1, double lon2, double lat1, double lat2){
  //math module that converts degrees to radians
  lon1 = radians(lon1);
  lon2 = radians(lon2);
  lat1 = radians(lat1);
  lat2 = radians(lat2);
  double haversineDist = haversineFormula(lon1, lon2, lat1, lat2);
  return haversineDist * 6371; // earth radius
}


double haversineFormula(double lon1, double lon2, double lat1, double lat2){
  double dlon = lon1 - lon2;
  double dlat = lat1 - lat2;
  double a =  pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2);
  return 2 * asin(sqrt(a));
}

double roundDouble(double value, int decimals){
  double mod = pow(10.0, decimals).toDouble();
  return ((value * mod).round().toDouble() / mod);
}