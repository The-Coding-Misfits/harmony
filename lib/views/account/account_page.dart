import 'package:flutter/material.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/widgets/account_page/check_in/check_in_display_row.dart';
import 'package:harmony/widgets/account_page/profile_photo.dart';
import 'package:harmony/widgets/account_page/user_favorites.dart';
import 'package:harmony/widgets/account_page/user_reviews.dart';
import 'package:harmony/widgets/general_use/hamburger_button.dart';
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

  final List<String> _tabs = <String>[
    'Favorite spots',
    "Reviews"
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
                // This widget takes the overlapping behavior of the SliverAppBar,
                // and redirects it to the SliverOverlapInjector below. If it is
                // missing, then it is possible for the nested "inner" scroll view
                // below to end up under the SliverAppBar even when the inner
                // scroll view thinks it has not been scrolled.
                // This is not necessary if the "headerSliverBuilder" only builds
                // widgets that do not overlap the next sliver.
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HamburgerButton(),
                        Visibility(
                          visible: innerBoxIsScrolled,
                          child: SizedBox(
                            width: 30,
                              height: 30,
                              child: ProfilePhoto(widget.user)
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
                                  child: ProfilePhoto(widget.user)
                              ),
                            )
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(widget.user.username, style: const TextStyle(fontSize: 20)),
                          ),
                        ),
                        ///CHECK IN CHART
                        CheckInDisplayRow(
                            widget.user
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                  expandedHeight: 350.0,
                  // The "forceElevated" property causes the SliverAppBar to show
                  // a shadow. The "innerBoxIsScrolled" parameter is true when the
                  // inner scroll view is scrolled beyond its "zero" point, i.e.
                  // when it appears to be scrolled below the SliverAppBar.
                  // Without this, there are cases where the shadow would appear
                  // or not appear inappropriately, because the SliverAppBar is
                  // not actually aware of the precise position of the inner
                  // scroll views.
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    // These are the widgets to put in each tab in the tab bar.
                    tabs: _tabs.map((String name) => Tab(text: name)).toList(),
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
                      // The "controller" and "primary" members should be left
                      // unset, so that the NestedScrollView can control this
                      // inner scroll view.
                      // If the "controller" property is set, then this scroll
                      // view will not be associated with the NestedScrollView.
                      // The PageStorageKey should be unique to this ScrollView;
                      // it allows the list to remember its scroll position when
                      // the tab view is not on the screen.
                      key: PageStorageKey<String>(name),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          // This is the flip side of the SliverOverlapAbsorber
                          // above.
                          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(8.0),
                          // In this example, the inner scroll view has
                          // fixed-height list items, hence the use of
                          // SliverFixedExtentList. However, one could use any
                          // sliver widget here, e.g. SliverList or SliverGrid.
                          sliver: SliverFixedExtentList(
                            // The items in this example are fixed to 48 pixels
                            // high. This matches the Material Design spec for
                            // ListTile widgets.
                            itemExtent: 48.0,
                            delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                // This builder is called for each child.
                                // In this example, we just number each list item.
                                return ListTile(
                                  title: Text('Item $index'),
                                );
                              },
                              // The childCount of the SliverChildBuilderDelegate
                              // specifies how many children this inner list
                              // has. In this example, each tab has a list of
                              // exactly 30 items, but this is arbitrary.
                              childCount: 30,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
        bottomNavigationBar: HarmonyBottomNavigationBar(
          PAGE_ENUM.ACCOUNT_PAGE
      ),
      ),
    );
  }
}



/*slivers: [
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
SliverToBoxAdapter(
child: MenuTabBar(
widget.user
),
)
/*SliverToBoxAdapter(
                child: MenuWidget(favoritesWidget, reviewsWidget),
              )*/
],
)*/