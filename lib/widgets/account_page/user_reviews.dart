import 'package:flutter/material.dart';
import 'package:harmony/models/review.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/services/auth_service.dart';
import 'package:harmony/services/firestore.dart';
import 'package:harmony/widgets/general_use/review_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class UserReviews extends StatefulWidget {
  final HarmonyUser user;
  const UserReviews(this.user);

  @override
  UserReviewsState createState() => UserReviewsState();
}

class UserReviewsState extends State<UserReviews> {
  late HarmonyUser user = widget.user;

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
          child: StaggeredGridView.countBuilder(
            staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
            crossAxisCount: 2,
            itemCount: user.reviewIds.length,
            itemBuilder: (BuildContext context, int index) {
              var reviewId = user.reviewIds[index];

              return FutureBuilder(
                future: FireStoreService().getReviewFromId(reviewId),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Review review = snapshot.data;

                    return ReviewCard(
                      review,
                      13
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