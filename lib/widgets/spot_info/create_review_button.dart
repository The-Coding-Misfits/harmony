import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/views/add_place/create_review_page.dart';

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
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CreateReviewPage(widget.place))
        );
      },
      icon: const Icon(Icons.comment),
    );
  }
}