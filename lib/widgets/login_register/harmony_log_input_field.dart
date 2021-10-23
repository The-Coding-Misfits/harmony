import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HarmonyLogInput extends StatelessWidget {

  final bool isPassword;
  final String hintText;
  final Icon prefixIcon;

  final TextEditingController _controller = TextEditingController();
  String get currText => _controller.text;

  HarmonyLogInput(this.prefixIcon, this.hintText, this.isPassword, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        obscureText: isPassword,
        controller: _controller,
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
