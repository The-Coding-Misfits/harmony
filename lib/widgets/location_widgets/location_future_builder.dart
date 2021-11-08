import 'package:flutter/material.dart';
import 'package:harmony/services/location_service.dart';
import 'package:location/location.dart';

class LocationFutureBuilder extends StatelessWidget {
  final Function(LocationData) onLocationGetWidgetCallback;
  const LocationFutureBuilder(this.onLocationGetWidgetCallback);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LocationData>(
      future: LocationService().getLocation(),
      builder: (BuildContext context, AsyncSnapshot<LocationData> snapshot) {

        if (snapshot.hasData){
          return onLocationGetWidgetCallback(snapshot.data!);
        }
        else if (snapshot.hasError) {
          return Column(
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ],
          );
        }
        else {
          return Column(
            children: const [
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Loading...'),
              )
            ],
          );
        }
      },
    );
  }
}
