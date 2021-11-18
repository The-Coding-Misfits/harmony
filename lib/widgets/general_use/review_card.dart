import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/models/review.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/services/firestore.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/views/account/account_page.dart';
import 'package:harmony/widgets/general_use/rating_widget.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  final bool forSpotInfo;
  final double contentSize;

  const ReviewCard(this.review, this.contentSize, {Key? key}) :
      forSpotInfo = false,
      super(key: key);

  const ReviewCard.forSpotInfo(this.review, this.contentSize,) :
      forSpotInfo = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
      child: GestureDetector(
        onTap: () {
          handleTap(context);
        },
        child: Card(
          color: Colors.white,
          child: Column(
              children: [
                ListTile(
                  title: FutureBuilder(
                    future: forSpotInfo ? FireStoreService().getUserFromId(review.authorID) : FireStoreService().getPlaceFromId(review.placeID),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        var data = snapshot.data;

                        return forSpotInfo ? Text(data.username) : Text(data.name);
                      } else {
                        return const Text("Loading...");
                      }
                    },
                  ),
                  subtitle: Row(
                    children: [
                      RatingWidget(review.rating.toDouble(), contentSize),
                      Text(
                        " ${review.rating.toDouble()}/5.0",
                        style: TextStyle(
                          fontSize: contentSize
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
                    child: Text(review.content),
                  ),
                )
              ]
          ),
        ),
      )
    );
  }
  void handleTap(BuildContext context) async{
    Place place = await FireStoreService().getPlaceFromId(review.placeID);
    if(forSpotInfo){
      HarmonyUser user = await FireStoreService().getUserFromId(review.authorID);
      //not best practice but whatever
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountPage(
              user,
            pushedFromSpotInfo: forSpotInfo,
          ))
      );
    }else{
      Navigator.pushNamed(
          context,
          kSpotInfoRouteName,
          arguments: {
            "place": place,
            "distance": null,
            "imageUrl": null,
          }
      );
    }
  }
}