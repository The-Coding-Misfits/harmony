import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:harmony/models/place.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'map_constants.dart';
import 'map_popup_widgets/place_popup.dart';
import 'markers.dart';

class HarmonyNearbyMap extends StatefulWidget {
  final List<Place> placesNear;
  final LocationData userLocation;

  const HarmonyNearbyMap({Key? key, required this.placesNear, required this.userLocation}) : super(key: key);
  @override
  _HarmonyNearbyMapState createState() => _HarmonyNearbyMapState();
}

class _HarmonyNearbyMapState extends State<HarmonyNearbyMap> {
  /// Used to trigger showing/hiding of popups.
  final PopupController _popupLayerController = PopupController();


  List<Marker> _buildMarkers() {
    List<Marker> placeMarkers = [];
    for (Place place in widget.placesNear){
      print("near places map ${place.name}");
      placeMarkers.add(Markers().getPlaceMarker(place));
    }
    return placeMarkers;
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> _markers = _buildMarkers();
    LatLng coords = LatLng(widget.userLocation.latitude!, widget.userLocation.longitude!);

    return FlutterMap(
      options: MapOptions(
        zoom: 15.0,
        center: coords,
        onTap: (_, __) => _popupLayerController
            .hideAllPopups(), // Hide popup when the map is tapped.
      ),
      children: [
        TileLayerWidget(
          options: TileLayerOptions(
            urlTemplate: kUrlTemplate ,
              additionalOptions: kMapAdditionalInfo
          ),
        ),
        Markers().getNearbyPageMarker(coords),
        PopupMarkerLayerWidget(
          options: PopupMarkerLayerOptions(
            popupController: _popupLayerController,
            markers: _markers,
            markerRotateAlignment:
            PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
            popupBuilder: (BuildContext context, Marker marker){
              Place correspondingPlace = widget.placesNear.elementAt(_markers.indexOf(marker));
              return PlacePopup(correspondingPlace, widget.userLocation);
            }
          ),
        ),
      ],
    );
  }
}

