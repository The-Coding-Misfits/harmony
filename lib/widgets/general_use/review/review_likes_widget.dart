import 'package:flutter/material.dart';
import 'package:harmony/models/associative_entities/like.dart';
import 'package:harmony/models/review.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/services/auth_service.dart';

class ReviewLikesWidget extends StatefulWidget {
  final Review review;

  const ReviewLikesWidget(this.review);

  @override
  State<ReviewLikesWidget> createState() => _ReviewLikesWidgetState();
}

class _ReviewLikesWidgetState extends State<ReviewLikesWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: handleTap,
          child: Icon(
            didCurrentUserLikedThisReview() ? Icons.favorite : Icons.favorite_border_outlined,
            color: Colors.red,
          ),
        ),
        Text(
          widget.review.getLikeCount().toString(),
          style: const TextStyle(
            fontSize: 12
          ),
        )
      ],
    );
  }

  bool didCurrentUserLikedThisReview(){
    HarmonyUser currentUser = AuthService.currHarmonyUser!;
    for(Like like in widget.review.likes){
      if (like.userId == currentUser.id){
        return true;
      }
    }
    return false;
  }

  void handleTap(){

  }
}
