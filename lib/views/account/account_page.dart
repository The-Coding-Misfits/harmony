import 'package:flutter/material.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/widgets/general_use/harmony_bottom_navigation_bar.dart';


class AccountPage extends StatefulWidget {

  final HarmonyUser user;
  const AccountPage(this.user, {Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  // TODO
  Widget favoritesWidget = const Text("favorites");
  Widget reviewsWidget = const Text("reviews");

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
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: Image.asset("assets/images/dummy-profile-pic.png", scale: 3),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(widget.user.username, style: const TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    SizedBox(
                      child: TextButton(
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
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                    SizedBox(
                      child: TextButton(
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
                      width: MediaQuery.of(context).size.width / 2,
                    )
                  ],
                ),
              ),
              const Divider(thickness: 2),
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
}

