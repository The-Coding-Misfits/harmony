import 'package:flutter/material.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/services/auth_service.dart';

class UserReviews extends StatefulWidget {
  const UserReviews({Key? key}) : super(key: key);

  @override
  UserReviewsState createState() => UserReviewsState();
}

class UserReviewsState extends State<UserReviews> {
  HarmonyUser user = AuthService.currHarmonyUser!;

  @override
  Widget build(BuildContext context) {
    if (user.favoritesID.isEmpty) {
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
        ),
      );
    }
  }
}