import 'package:flutter/material.dart';
import 'package:harmony/utilites/constants.dart';

class MenuWidget extends StatefulWidget {
  final Widget favoritesWidget;
  final Widget reviewsWidget;

  const MenuWidget(this.favoritesWidget, this.reviewsWidget, {Key? key}) : super(key: key);

  @override
  MenuWidgetState createState() => MenuWidgetState();
}

class MenuWidgetState extends State<MenuWidget> {
  late Widget selectedWidget;

  @override
  void initState() {
    super.initState();
    selectedWidget = widget.favoritesWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              child: Column(
                children: [
                  TextButton(
                    child: Text(
                      "Favorite Spots",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: selectedWidget == widget.favoritesWidget ? const Color(0xff00CA9D) : Colors.black
                      ),
                    ),
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.transparent)
                    ),
                    onPressed: () {
                      setState(() {
                        selectedWidget = widget.favoritesWidget;
                      });
                    },
                  ),
                  Divider(
                    thickness: 2,
                    indent: 40,
                    endIndent: 40,
                    color: selectedWidget == widget.favoritesWidget ? kHarmonyColor : Colors.transparent,
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
                          color: selectedWidget == widget.reviewsWidget ? const Color(0xff00CA9D) : Colors.black
                      ),
                    ),
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.transparent)
                    ),
                    onPressed: () {
                      setState(() {
                        selectedWidget = widget.reviewsWidget;
                      });
                    },
                  ),
                  Divider(
                    thickness: 2,
                    indent: 40,
                    endIndent: 40,
                    color: selectedWidget == widget.reviewsWidget ? kHarmonyColor : Colors.transparent,
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width / 2,
            )
          ],
        ),
        selectedWidget
      ],
    );
  }
}