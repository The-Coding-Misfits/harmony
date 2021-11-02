import 'package:flutter/material.dart';
import 'package:harmony/services/auth_service.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/utilites/login_register_states/login_state.dart';
import 'package:harmony/widgets/login_register/harmony_shiny_button.dart';
import 'package:harmony/widgets/login_register/harmony_log_input_field.dart';

class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  final AuthService authService = AuthService();

  HarmonyLogInput emailInputField = HarmonyLogInput(
      const Icon(Icons.alternate_email, size: 25, color: Colors.grey),
      "Email Address",
      false,

  );
  HarmonyLogInput passwordInputField = HarmonyLogInput(
      const Icon(Icons.lock, size: 25, color: Colors.grey),
      "Password",
      true
  );


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///Logo section
            Expanded(
              flex: 4,
              child: Hero(
                tag: "harmony_logo",
                child: Image.asset("assets/images/harmony.png", scale: 5),
              ),
            ),
            ///Input section
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  emailInputField,
                  passwordInputField,
                ],
              ),
            ),
            ///Button
            Flexible(
                flex: 2,
                child: HarmonyShinyButton(
                  "Login",
                      () => tapOnLogButton(context),
                )
            ),
            ///Register
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  const Text(
                    "Not a member yet?",
                    style: TextStyle(
                      fontSize: 14,
                    ) ,
                  ),
                  const SizedBox(height: 5,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context,
                          kRegisterPageRouteName
                      );
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff00CA9D)
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void tapOnLogButton(BuildContext context) async {
    LOGIN_STATE loginState = await authService.logUser(emailInputField.currText, passwordInputField.currText);

    if (loginState == LOGIN_STATE.SUCCESSFUL) {
      Navigator.pushNamedAndRemoveUntil(context, kDiscoverPageRouteName, (route) => false);
    } else if (loginState == LOGIN_STATE.WRONG_PASSWORD) {
      var snackbar = const SnackBar(content: Text("Wrong password!"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else if (loginState == LOGIN_STATE.USER_NOT_FOUND) {
      var snackbar = const SnackBar(content: Text("User not found!"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else if (loginState == LOGIN_STATE.UNKNOWN) {
      var snackbar = const SnackBar(content: Text("Unknown error!"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}