import 'package:flutter/material.dart';
import 'package:harmony/models/associative_entities/like.dart';
import 'package:harmony/models/review.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/services/auth_service.dart';

class ReviewLikesWidget extends StatelessWidget {
  final Review review;

  const ReviewLikesWidget(this.review);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          didCurrentUserLikedThisReview() ? Icons.favorite : Icons.favorite_border_outlined,
          color: Colors.red,
        ),
        Text(
          review.getLikeCount().toString(),
          style: const TextStyle(
            fontSize: 7
          ),
        )
      ],
    );
  }


  bool didCurrentUserLikedThisReview(){
    HarmonyUser currentUser = AuthService.currHarmonyUser!;
    for(Like like in review.likes){
      if (like.userId == currentUser.id){
        return true;
      }
    }
    return false;
  }
}
