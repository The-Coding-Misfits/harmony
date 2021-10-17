import 'package:flutter/material.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
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
                      builder: (BuildContext context) => const HomePage(),
                    ),
                  )
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
              ),
            ),
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