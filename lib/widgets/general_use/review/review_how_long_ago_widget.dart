import 'package:flutter/material.dart';
import 'package:harmony/models/review.dart';
import 'package:timeago/timeago.dart' as timeago;

class ReviewHowLongAgoWidget extends StatelessWidget {
  final Review review;
  const ReviewHowLongAgoWidget(this.review);

  @override
  Widget build(BuildContext context) {
    return Text(
      getHowLongAgo(),
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500
      ),
    );
  }


  String getHowLongAgo(){
    return timeago.format(review.timeAdded);
  }
}
