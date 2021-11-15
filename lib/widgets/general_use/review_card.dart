import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/models/review.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/services/firestore.dart';
import 'package:harmony/widgets/general_use/rating_widget.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  ReviewCard(this.review, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Card(
        color: Colors.white,
        child: Column(
            children: [
              ListTile(
                title: FutureBuilder(
                  future: FireStoreService().getPlaceFromId(review.placeID),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      Place place = snapshot.data;

                      return Text(place.name);
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
              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
                child: Text(review.content),
              )
            ]
        ),
      )
    );
  }
}