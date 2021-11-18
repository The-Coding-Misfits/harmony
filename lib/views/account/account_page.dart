import 'package:flutter/material.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/widgets/account_page/check_in/check_in_display_row.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Center(child: ProfilePhoto(widget.user))
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(widget.user.username, style: const TextStyle(fontSize: 20)),
                ),
              ),
            ),
            ///CHECK IN CHART
            SliverToBoxAdapter(
              child: CheckInDisplayRow(
                widget.user
              ),
            ),
            /*SliverToBoxAdapter(
              child: MenuWidget(favoritesWidget, reviewsWidget),
            )*/
          ],
        )
      ),
      bottomNavigationBar: HarmonyBottomNavigationBar(
          PAGE_ENUM.ACCOUNT_PAGE
      ),
    );
  }
}

