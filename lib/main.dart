import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:harmony/services/auth_service.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/views/discover/discover_page.dart';
import 'package:harmony/views/login&register/login.dart';
import 'package:harmony/views/login&register/register.dart';
import 'package:harmony/views/state_pages/something_went_wrong.dart';
import 'package:harmony/views/add_place/add_place.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          String initialRoute = auth.currentUser == null ? kLoginPageRouteName : kMainPageRouteName;

          return MaterialApp(
            title: "Harmony",
            theme: ThemeData(
              fontFamily: "Montserrat",
              primaryColor: const Color(0xff00CA9D)
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: initialRoute,
            routes: {
              kLoginPageRouteName : (context) => const LoginPage(),
              kMainPageRouteName : (context) => DiscoverPage(),
              kRegisterPageRouteName : (context) => const RegisterPage(),
              kAddPlacePageRouteName : (context) => const AddPlace()
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                Hero(
                    tag: "harmony_logo",
                    child: Image.asset("assets/images/harmony.png")
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: CircularProgressIndicator(),
                )
              ],
            )
          ),
        );
      },
    );
  }
}
