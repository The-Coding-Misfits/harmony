import 'package:flutter/material.dart';
import 'package:harmony/services/auth_service.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/utilites/login_register_states/delete_state.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Settings", style: TextStyle(color: Colors.black)),
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              title: const Text("Delete Account"),
              onTap: () async {
                var delete = await authService.deleteAccount();

                if (delete == DELETE_STATE.SUCCESSFUL) {
                  Navigator.pushReplacementNamed(
                      context,
                      kLoginPageRouteName
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Error deleting account!"),
                    )
                  );
                }
              },
            ),
          ]
        ).toList()
      ),
    );
  }
}