import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:harmony/views/login&register/login.dart';
import 'package:harmony/views/state_pages/something_went_wrong.dart';
import 'package:harmony/services/auth_service.dart';
import 'package:harmony/utilites/constants.dart';

final Future<FirebaseApp> _initialization = Firebase.initializeApp();

class StartingPage extends StatefulWidget {
  const StartingPage({Key? key}) : super(key: key);

  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          String initialRoute = auth.currentUser == null ? kLoginPageRouteName : kMainPageRouteName;

          return MaterialApp(
            initialRoute: initialRoute,
            routes: {
              kLoginPageRouteName : (context) => LoginPage(),
              /*kRegisterPageRouteName : (context) => RegisterPage(),
              kMainPageRouteName : (context) => MainPage(),*/
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return  Container(
          color: Colors.white,
          child: Center(
            child: Hero(
                tag: "harmony_logo",
                child: Image.asset("assets/images/harmony.png") /*SvgPicture.asset(
                  "assets/images/harmony.svg"
                )*/
            ),
          ),
        );
      },
    );
  }
}
