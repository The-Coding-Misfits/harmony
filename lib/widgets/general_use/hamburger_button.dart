import 'package:flutter/material.dart';
import 'package:harmony/services/auth_service.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/utilites/login_register_states/signout_state.dart';

class HamburgerButton extends StatelessWidget {
  HamburgerButton({Key? key}) : super(key: key);
  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("Settings"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text("About Harmony"),
                    onTap: () {
                      showAboutDialog(
                          context: context,
                          applicationVersion: "1.0.0a",
                          applicationIcon: Image.asset("assets/images/harmony.png", scale: 6,),
                          applicationName: "Harmony"
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text("Log Out"),
                    onTap: () async {
                      SIGNOUT_STATE signOutState = await authService.signOutUser();

                      if (signOutState == SIGNOUT_STATE.SUCCESSFUL) {
                        Navigator.pushReplacementNamed(
                            context,
                            kLoginPageRouteName
                        );
                      } else if (signOutState == SIGNOUT_STATE.ERROR) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("An error occurred."))
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      icon: const Icon(
        Icons.menu,
        size: 25,
      ),
    );
  }
}
