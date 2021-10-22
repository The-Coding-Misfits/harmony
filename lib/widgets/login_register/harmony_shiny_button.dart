import 'package:flutter/material.dart';

class HarmonyShinyButton extends StatelessWidget {
  final String text;
  final Function() onPress;
  final double size;


  HarmonyShinyButton(this.text, this.onPress, {this.size = 60});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
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
        onPressed: onPress,
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
        ),
      ),
    );
  }
}
