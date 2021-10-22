import 'package:flutter/material.dart';
import 'package:harmony/services/auth_service.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/utilites/register_state.dart';
import 'package:harmony/widgets/login_register/harmony_log_input_field.dart';
import 'package:harmony/widgets/login_register/harmony_shiny_button.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  HarmonyLogInput emailInputField = HarmonyLogInput(
    const Icon(Icons.person, size: 25, color: Colors.grey),
    "Email Address",
    false,
  );

  HarmonyLogInput passwordInputField = HarmonyLogInput(
      const Icon(Icons.lock, size: 25, color: Colors.grey),
      "Password",
      true
  );

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                "Register",
                    () => tapOnRegisterButton(context),
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
                  "Already have an account?",
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
                    "Login",
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
    );
  }

  void tapOnRegisterButton(BuildContext context) async {
    REGISTER_STATE loginState = await authService.registerUser(emailInputField.currText, passwordInputField.currText);

    if (loginState == REGISTER_STATE.SUCCESSFUL) {
      Navigator.pushNamedAndRemoveUntil(context, kMainPageRouteName, (route) => false);
    }
  }
}
