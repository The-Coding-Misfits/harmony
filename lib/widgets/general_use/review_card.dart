import 'package:flutter/material.dart';
import 'package:harmony/models/review.dart';
import 'package:harmony/services/firestore.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  ReviewCard(this.review, {Key? key}) : super(key: key);

  String? pfpUrl;

  getPfp(String userId) async {
    if (pfpUrl == null) {
      pfpUrl = await FireStoreService().getPfpFromId(userId);
      return pfpUrl;
    } else {
      return pfpUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget pfpWidget = FutureBuilder(
      future: getPfp(review.authorID),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Image.asset("assets/images/dummy-profile-pic.png");
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Image.network(snapshot.data, fit: BoxFit.fill);
        } else {
          return Container(color: Colors.grey);
        }
      },
    );

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Column(
        children: [
          ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: CircleAvatar(
                radius: 100,
                child: pfpWidget,
              ),
            ),
            title: Text(),
          ),
        ]
      ),
    );
  }
}