import 'package:flutter/material.dart';
import 'package:harmony/widgets/general_use/rating_widget.dart';

class PlaceCard extends StatelessWidget {
  final double rating;
  final String imageUrl;
  final double distance;

  const PlaceCard({Key? key, required this.rating, required this.imageUrl, required this.distance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            Image.asset(imageUrl),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5, left: 10),
                child: Text('Great place for a picnic!', style: TextStyle(fontSize: 20)),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 5, left: 10),
                  child: Row(
                    children: [
                      RatingWidget(rating),
                      Text(' $rating/5.0 • ${distance}KM Nearby',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xff6a6a6a),
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}