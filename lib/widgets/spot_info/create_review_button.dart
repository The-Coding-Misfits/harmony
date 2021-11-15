import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';

class CreateReviewIconButton extends StatefulWidget {
  final Place place;

  const CreateReviewIconButton(this.place, {Key? key}) : super(key: key);

  @override
  CreateReviewIconButtonState createState() => CreateReviewIconButtonState();
}

class CreateReviewIconButtonState extends State<CreateReviewIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.comment),
    );
  }
}