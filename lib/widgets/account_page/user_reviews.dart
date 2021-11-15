import 'package:flutter/material.dart';
import 'package:harmony/models/review.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/services/auth_service.dart';
import 'package:harmony/services/firestore.dart';
import 'package:harmony/widgets/general_use/review_card.dart';

class UserReviews extends StatefulWidget {
  const UserReviews({Key? key}) : super(key: key);

  @override
  UserReviewsState createState() => UserReviewsState();
}

class UserReviewsState extends State<UserReviews> {
  HarmonyUser user = AuthService.currHarmonyUser!;

  @override
  Widget build(BuildContext context) {
    if (user.reviewIds.isEmpty) {
      return Expanded(
          child: Container(
            color: const Color(0xffefefef),
            child: const Align(
              alignment: Alignment.center,
              child: Text("No reviews!"),
            ),
          )
      );
    } else {
      return Expanded(
        child: Container(
          color: const Color(0xffefefef),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2
            ),
            itemBuilder: (BuildContext context, int index) {
              var reviewId = user.reviewIds[index];

              return FutureBuilder(
                future: FireStoreService().getReviewFromId(reviewId),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Review review = snapshot.data;

                    return ReviewCard(
                      review
                    );
                  }

                  return const Text("Loading review...");
                },
              );
            },
          ),
        ),
      );
    }
  }
}