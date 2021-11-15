import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/models/review.dart';
import 'package:harmony/services/firestore.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/widgets/general_use/rating_widget.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  final bool forSpotInfo;

  const ReviewCard(this.review, {Key? key}) :
      forSpotInfo = true,
      super(key: key);

  ReviewCard.forSpotInfo(this.review) :
      forSpotInfo = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
      child: GestureDetector(
        onTap: () async {
          Place place = await FireStoreService().getPlaceFromId(review.placeID);

          Navigator.pushNamed(
              context,
              kSpotInfoRouteName,
              arguments: {
                "place": place,
                "distance": null,
                "imageUrl": null,
              }
          );
        },
        child: Card(
          color: Colors.white,
          child: Column(
              children: [
                ListTile(
                  title: FutureBuilder(
                    future: forSpotInfo ? FireStoreService().getUserFromId(review.authorID) : FireStoreService().getPlaceFromId(review.placeID),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        var data = snapshot.data;

                        return forSpotInfo ? Text(data.username) : Text(data.name);
                      } else {
                        return const Text("Loading...");
                      }
                    },
                  ),
                  subtitle: Row(
                    children: [
                      RatingWidget(review.rating.toDouble(), 13),
                      Text(
                        " ${review.rating.toDouble()}/5.0",
                        style: const TextStyle(
                            fontSize: 13
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
                    child: Text(review.content),
                  ),
                )
              ]
          ),
        ),
      )
    );
  }
}