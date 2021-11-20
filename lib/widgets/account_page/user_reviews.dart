import 'package:flutter/material.dart';
import 'package:harmony/models/review.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/services/firestore.dart';
import 'package:harmony/widgets/general_use/review/review_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class UserReviews extends StatelessWidget {
  final HarmonyUser user;
  const UserReviews(this.user);

  @override
  Widget build(BuildContext context) {
    if (user.reviewIds.isEmpty) {
      return getEmptyWidget();
    }
    return SliverStaggeredGrid.countBuilder(
      crossAxisCount: 2,
      staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
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
    );
  }


  Widget getEmptyWidget(){
    return SliverToBoxAdapter(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Container(
            child: const Text(
                "No reviews!"
            ),
          ),
        ),
      ),
    );
  }
}