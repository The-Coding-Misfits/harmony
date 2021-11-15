import 'package:flutter/material.dart';
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
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 100
          ),
          child: Column(
              children: [
                ListTile(
                  title: FutureBuilder(
                    future: FireStoreService().getUserFromId(review.authorID),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        HarmonyUser user = snapshot.data;

                        return Text(user.username);
                      } else {
                        return const Text("Loading...");
                      }
                    },
                  ),
                  subtitle: RatingWidget(review.rating.toDouble(), 10),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                  child: Text(review.content),
                )
              ]
          ),
        )
      )
    );
  }
}