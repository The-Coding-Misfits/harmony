import 'package:flutter/material.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/viewmodel/account/account_viewmodel.dart';
import 'package:harmony/viewmodel/account/check_in_chunk.dart';
import 'package:harmony/widgets/account_page/profile_photo.dart';
import 'package:harmony/widgets/account_page/user_favorites.dart';
import 'package:harmony/widgets/account_page/user_reviews.dart';
import 'package:harmony/widgets/general_use/harmony_bottom_navigation_bar.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class AccountPage extends StatefulWidget {

  final HarmonyUser user;
  final AccountPageViewModel accountPageViewModel = AccountPageViewModel();
  AccountPage(this.user, {Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  Color activeDividerColor = kHarmonyColor;
  late Widget favoritesWidget = UserFavorites(widget.user);
  late Widget reviewsWidget = UserReviews(widget.user);

  late List<CheckInChunk> checkInChunks = widget.accountPageViewModel.getChunks(widget.user);

  late Widget selectedWidget;
  @override
  void initState() {
    super.initState();
    //Just a personal preference really
    selectedWidget = favoritesWidget;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ProfilePhoto(widget.user)
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(widget.user.username, style: const TextStyle(fontSize: 20)),
              ),
              ///CHECK IN CHART
              getChartWidget(),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    SizedBox(
                      child: Column(
                        children: [
                          TextButton(
                            child: Text(
                              "Favorite Spots",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: selectedWidget == favoritesWidget ? const Color(0xff00CA9D) : Colors.black
                              ),
                            ),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(Colors.transparent)
                            ),
                            onPressed: () {
                              setState(() {
                                selectedWidget = favoritesWidget;
                              });
                            },
                          ),
                          Divider(
                              thickness: 2,
                            indent: 40,
                            endIndent: 40,
                            color: selectedWidget == favoritesWidget ? activeDividerColor : Colors.transparent,
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          TextButton(
                            child: Text(
                              "My Reviews",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: selectedWidget == reviewsWidget ? const Color(0xff00CA9D) : Colors.black
                              ),
                            ),
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(Colors.transparent)
                            ),
                            onPressed: () {
                              setState(() {
                                selectedWidget = reviewsWidget;
                              });
                            },
                          ),
                          Divider(
                              thickness: 2,
                            indent: 40,
                            endIndent: 40,
                            color: selectedWidget == reviewsWidget ? activeDividerColor : Colors.transparent,
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width / 2,
                    )
                  ],
                ),
              ),
              selectedWidget,
            ],
          ),
        )
      ),
      bottomNavigationBar: HarmonyBottomNavigationBar(
          PAGE_ENUM.ACCOUNT_PAGE
      ),
    );
  }



  Widget getChartWidget(){
    if(checkInChunks.isEmpty){
      return const Padding(
        padding: EdgeInsets.only(top: 15),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "You haven't check in yet!",
            style: TextStyle(
              fontSize: 10
            ),
          ),
        ),
      );
    }
    else {
      return SfSparkLineChart.custom(
        //Enable marker
        trackball: const SparkChartTrackball(

        ),
        marker: const SparkChartMarker(
            displayMode: SparkChartMarkerDisplayMode.none),
        //Enable data label
        labelDisplayMode: SparkChartLabelDisplayMode.none,
        xValueMapper: (int index) => index,
        yValueMapper: (int index) => checkInChunks[index].numOfCheckIns,
        dataCount: checkInChunks.length,
      );
    }
  }
}

