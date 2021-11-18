import 'package:flutter/material.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/widgets/account_page/check_in/check_in_chart.dart';
import 'package:harmony/widgets/account_page/profile_photo.dart';
import 'package:harmony/widgets/account_page/user_favorites.dart';
import 'package:harmony/widgets/account_page/user_reviews.dart';
import 'package:harmony/widgets/general_use/harmony_bottom_navigation_bar.dart';


class AccountPage extends StatefulWidget {

  final HarmonyUser user;
  AccountPage(this.user, {Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  Color activeDividerColor = kHarmonyColor;
  late Widget favoritesWidget = UserFavorites(widget.user);
  late Widget reviewsWidget = UserReviews(widget.user);

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
              CheckInChart(
                widget.user
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

  Widget getMenuWidget() {
    return Padding(
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
    );
  }
}

