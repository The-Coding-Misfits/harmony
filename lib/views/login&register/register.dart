import 'package:flutter/material.dart';
import 'package:harmony/services/auth_service.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/utilites/login_register_states/register_state.dart';
import 'package:harmony/widgets/login_register/harmony_log_input_field.dart';
import 'package:harmony/widgets/login_register/harmony_shiny_button.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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

  HarmonyLogInput usernameInputField = HarmonyLogInput(
      const Icon(Icons.person, size: 25, color: Colors.grey),
      "Username",
      false
  );

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
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
            flex: 4,
            child: Column(
              children: [
                usernameInputField,
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
                      kLoginPageRouteName
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
    REGISTER_STATE registerState = await authService.registerUser(
      emailInputField.currText,
      usernameInputField.currText,
      passwordInputField.currText
    );

    if (registerState == REGISTER_STATE.SUCCESSFUL) {
      Navigator.pushNamedAndRemoveUntil(context, kDiscoverPageRouteName, (route) => false);
    } else if (registerState == REGISTER_STATE.EMAIL_ALREADY_IN_USE) {
      var snackbar = const SnackBar(content: Text("That email is alredy being used!"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else if (registerState == REGISTER_STATE.WEAK_PASSWORD) {
      var snackbar = const SnackBar(content: Text("Password is too weak!"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else if (registerState == REGISTER_STATE.UNKNOWN_ERROR) {
      var snackbar = const SnackBar(content: Text("Unknown error!"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
