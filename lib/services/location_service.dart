import 'package:harmony/utilites/custom_exception.dart';
import 'package:location/location.dart';

class LocationService{
  LocationData? _currLocation;
  final Location _location = Location();

  void _startListenForLocation(){
    _location.onLocationChanged.listen((LocationData newLocation){
      _currLocation = newLocation;
    });
  }

  Future<LocationData> getLocation() async{

    if(_currLocation != null){
     return _currLocation!;
    } else {
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      _serviceEnabled = await _location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
        if (!_serviceEnabled) {
          return throw CustomException("Service not enabled!");
        }
      }

      _permissionGranted = await _location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await _location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return throw CustomException("Permission not granted!");
        }
      }
      _currLocation = await _location.getLocation();
      _startListenForLocation();
      return _currLocation!;
    }
  }


}