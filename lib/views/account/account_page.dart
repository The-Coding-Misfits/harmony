import 'package:flutter/material.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/services/auth_service.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/widgets/account_page/check_in/check_in_display_row.dart';
import 'package:harmony/widgets/account_page/profile_photo.dart';
import 'package:harmony/widgets/account_page/user_favorites.dart';
import 'package:harmony/widgets/account_page/user_reviews.dart';
import 'package:harmony/widgets/general_use/hamburger_button.dart';
import 'package:harmony/widgets/general_use/harmony_bottom_navigation_bar.dart';


class AccountPage extends StatelessWidget {

  final HarmonyUser user;
  final bool pushedFromSpotInfo;
  AccountPage(this.user, {Key? key, this.pushedFromSpotInfo = false}) : super(key: key);

  final List<String> _tabs = <String>[
    'FAVORITE SPOTS',
    "REVIEWS"
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length, // This is the number of tabs.
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        pushedFromSpotInfo ? const SizedBox() : HamburgerButton(),
                        Visibility(
                          visible: innerBoxIsScrolled,
                          child: SizedBox(
                            width: 30,
                              height: 30,
                              child: ProfilePhoto(
                                user,
                                canPhotoBeChanged: false,
                              )
                          ),
                        ),
                      ]
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      children: [
                        const SizedBox( // to account for hamburger button
                          height: 40,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Visibility(
                              visible: !innerBoxIsScrolled,
                              child: Center(
                                  child: ProfilePhoto(
                                      user,
                                    canPhotoBeChanged: canPhotoBeChanged(),
                                  )
                              ),
                            )
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(user.username, style: const TextStyle(fontSize: 20)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          child: SizedBox(
                            height: 50,
                            child: CheckInDisplayRow(
                                user
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                  expandedHeight: 375.0,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    // These are the widgets to put in each tab in the tab bar.
                    tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                    //line config
                    indicatorColor: kHarmonyColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    //label config
                    unselectedLabelColor: Colors.grey,
                    labelColor: kHarmonyColor,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            // These are the contents of the tab views, below the tabs.
            children: _tabs.map((String name) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  // This Builder is needed to provide a BuildContext that is
                  // "inside" the NestedScrollView, so that
                  // sliverOverlapAbsorberHandleFor() can find the
                  // NestedScrollView.
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      key: PageStorageKey<String>(name),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          // This is the flip side of the SliverOverlapAbsorber
                          // above.
                          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(8.0),
                          sliver: getTabBarViewAccordingToTab(name)
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
        bottomNavigationBar: pushedFromSpotInfo ? const SizedBox() :  HarmonyBottomNavigationBar(
            PAGE_ENUM.ACCOUNT_PAGE
        ),
      ),
    );
  }
  
  Widget getTabBarViewAccordingToTab(String tabName){
    if (tabName == "REVIEWS") {
      return UserReviews(user);
    } else {
      return UserFavorites(user);
    }
  }

  bool canPhotoBeChanged(){
    return user.uid == AuthService.currHarmonyUser!.uid;
  }
}