import 'package:flutter/material.dart';
import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/widgets/general_use/harmony_bottom_navigation_bar.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: HarmonyBottomNavigationBar(
          PAGE_ENUM.ACCOUNT_PAGE
      ),
    );
  }
}
