import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/widgets/general_use/rating_widget.dart';

class PlaceCard extends StatelessWidget {
  final Place place;
  final double? distance;
  final String imageUrl;
  final double contentSize;
  const PlaceCard({required this.place, this.distance, required this.imageUrl, required this.contentSize, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              kSpotInfoRouteName,
              arguments: {
                "place": place,
                "distance": distance,
                "imageUrl": imageUrl,
              }
            );
          },
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 487 / 250,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        alignment: FractionalOffset.topCenter,
                        image: NetworkImage(imageUrl),//TODO DYNAMICALLY GET THE DOWNLOAD URL
                      )
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5, left: 10),
                  child: Text(place.name, style: TextStyle(fontSize: contentSize)),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 5, left: 10),
                    child: Row(
                      children: [
                        RatingWidget(place.rating, contentSize),
                        Text(distance == null ? ' ${place.rating}/5.0' : ' ${place.rating}/5.0 • ${distance!.toStringAsFixed(1)}KM Nearby',
                            style: TextStyle(
                                fontSize: contentSize - 1,
                                color: const Color(0xff6a6a6a),
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ],
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}