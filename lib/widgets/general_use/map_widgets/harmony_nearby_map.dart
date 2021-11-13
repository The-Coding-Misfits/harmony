import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:harmony/models/place.dart';
import 'package:latlong2/latlong.dart';
import 'map_popup_widgets/place_popup.dart';
import 'markers.dart';

class MapWithPopups extends StatefulWidget {
  final List<Place> placesNear;

  const MapWithPopups({Key? key, required this.placesNear}) : super(key: key);
  @override
  _MapWithPopupsState createState() => _MapWithPopupsState();
}

class _MapWithPopupsState extends State<MapWithPopups> {
  List<Marker> _markers = [];
  /// Used to trigger showing/hiding of popups.
  final PopupController _popupLayerController = PopupController();


  @override
  void initState() {
    super.initState();
    _markers = _buildMarkers();
  }



  List<Marker> _buildMarkers() {
    List<Marker> placeMarkers = [];
    for (Place place in widget.placesNear){
      placeMarkers.add(Markers().getPlaceMarker(place));
    }
    return placeMarkers;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        zoom: 5.0,
        center: LatLng(44.421, 10.404),
        onTap: (_, __) => _popupLayerController
            .hideAllPopups(), // Hide popup when the map is tapped.
      ),
      children: [
        TileLayerWidget(
          options: TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
        ),
        PopupMarkerLayerWidget(
          options: PopupMarkerLayerOptions(
            popupController: _popupLayerController,
            markers: _markers,
            markerRotateAlignment:
            PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
            popupBuilder: (BuildContext context, Marker marker){
              Place correspondingPlace = widget.placesNear.elementAt(_markers.indexOf(marker));
              return PlacePopup(correspondingPlace);
            }
          ),
        ),
      ],
    );
  }
}

