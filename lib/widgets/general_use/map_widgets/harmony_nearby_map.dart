import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'map_constants.dart';
import 'map_popup_widgets/place_popup.dart';
import 'markers.dart';

class HarmonyNearbyMap extends StatefulWidget {
  final List<Place> placesNear;
  final LocationData userLocation;
  final FilterModel filterModel;

  const HarmonyNearbyMap({Key? key, required this.placesNear, required this.userLocation, required this.filterModel}) : super(key: key);
  @override
  _HarmonyNearbyMapState createState() => _HarmonyNearbyMapState();
}

class _HarmonyNearbyMapState extends State<HarmonyNearbyMap> {
  /// Used to trigger showing/hiding of popups.
  final PopupController _popupLayerController = PopupController();


  List<Marker> _buildMarkers() {
    List<Marker> placeMarkers = [];
    for (Place place in widget.placesNear){
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
        zoom: 12.0,
        center: coords,
        onTap: (_, __) => _popupLayerController.hideAllPopups(), // Hide popup when the map is tapped.
      ),
      children: [
        TileLayerWidget(
          options: TileLayerOptions(
            urlTemplate: kUrlTemplate ,
              additionalOptions: kMapAdditionalInfo
          ),
        ),
        CircleLayerWidget(
          options: CircleLayerOptions(
            circles: [
              CircleMarker(
                point: coords,
                color: const Color(0xFFF5A623).withOpacity(0.5),
                radius: 50
              ),
              CircleMarker(
                point: coords,
                color: const Color(0xFFF5A623).withOpacity(0.3),
                radius: widget.filterModel.proximity * 100
              ),
            ]
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

