import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harmony/widgets/general_use/hamburger_button.dart';

class FilterTopBar extends StatelessWidget {
  final Function() onTapFilter;
  final String title;
  const FilterTopBar(this.onTapFilter, this.title);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HamburgerButton(),
          //App bar title
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          IconButton( //filter button
            onPressed: onTapFilter,
            icon: const Icon(
              Icons.filter_alt_sharp,
              size: 25,
            ),
          )
        ],
      ),
    );
  }
}
