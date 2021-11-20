import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:harmony/views/login&register/register.dart';
import 'package:harmony/services/auth_service.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/views/discover/discover_page.dart';
import 'package:harmony/views/login&register/login.dart';
import 'package:harmony/views/place/spot_info.dart';
import 'package:harmony/views/settings/settings_page.dart';
import 'package:harmony/views/state_pages/something_went_wrong.dart';
import 'package:harmony/views/place/add_place.dart';


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
  void initState() {
    super.initState();
  }

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
          String initialRoute = auth.currentUser == null ? kLoginPageRouteName : kDiscoverPageRouteName;

          if (auth.currentUser != null) {
            return FutureBuilder(
              future: AuthService().initCurrUser(auth.currentUser!.uid),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return MaterialApp(
                    title: "Harmony",
                    theme: ThemeData(
                        fontFamily: "Montserrat",
                        primaryColor: const Color(0xff00CA9D),
                        colorScheme: ColorScheme.fromSwatch().copyWith(
                            primary: const Color(0xff00CA9D),
                            secondary: const Color(0xff00CA9D)
                        )
                    ),
                    debugShowCheckedModeBanner: false,
                    initialRoute: initialRoute,
                    routes: {
                      kLoginPageRouteName : (context) => LoginPage(),
                      kDiscoverPageRouteName : (context) => const DiscoverPage(),
                      kRegisterPageRouteName : (context) => const RegisterPage(),
                      kAddPlacePageRouteName : (context) => AddPlace(),
                      kErrorPageRouteName : (context) => const SomethingWentWrong(),
                      kSettingsPageRouteName : (context) => SettingsPage(),
                      kSpotInfoRouteName : (context) => const SpotInfo()
                    },
                  );
                } else {
                  return loadingWidget();
                }
              },
            );
          }
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return loadingWidget();
      },
    );
  }

  Widget loadingWidget() {
    return Container(
      color: Colors.white,
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                  tag: "harmony_logo",
                  child: Image.asset("assets/images/harmony.png", scale: 4)
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: CircularProgressIndicator(color: Color(0xff00CA9D)),
              ),
            ],
          )
      ),
    );
  }
}
