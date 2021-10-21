import 'package:flutter/material.dart';

import 'login.dart';
import 'main.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _inputField(const Icon(Icons.person, size: 25, color: Colors.grey),
                "Email Address",
                false
            ),
            _inputField(const Icon(Icons.lock, size: 25, color: Colors.grey),
                "Password",
                true
            ),
            Container(
              height: 60,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 15, bottom: 50, left: 20, right: 20),
              decoration: const BoxDecoration(
                  color: Color(0xff00CA9D),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff00a781),
                      blurRadius: 10,
                      offset: Offset(0,5),
                      spreadRadius: 0,
                    ),
                  ]
              ),
              child: TextButton(
                onPressed: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const MyApp(),
                    ),
                  )
                },
                child: const Text(
                  "Register",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  const Text("Already have an account?", style: TextStyle(fontSize: 17)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage(),
                        ),
                      );
                    },
                    child: const Text("Log in", style: TextStyle(color: Color(0xff00CA9D), fontSize: 17)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputField(Icon prefixIcon, String hintText, bool isPassword) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 25),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xff5F5D70),
          ),
          fillColor: const Color(0xffFBFAFF),
          filled: true,
          prefixIcon: prefixIcon,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 50,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}