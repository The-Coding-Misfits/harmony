import 'package:flutter/material.dart';

class HarmonyShinyButton extends StatelessWidget {
  final String text;
  final Function() onPress;
  final double size;
  final bool isActive;
  final Color activeBGColor = const Color(0xff00CA9D);
  final Color inactiveBGColor = Colors.grey[600] as Color;
  final Color activeShadowColor = const Color(0xff00a781);
  final Color inactiveShadowColor = Colors.grey[700] as Color;

  HarmonyShinyButton(this.text, this.onPress, {Key? key, this.size = 60, this.isActive = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 15, bottom: 50, left: 20, right: 20),
      decoration: BoxDecoration(
          color: isActive ? activeBGColor : inactiveBGColor,
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          boxShadow: [
            BoxShadow(
              color: isActive ? activeShadowColor : inactiveShadowColor,
              blurRadius: 10,
              offset: const Offset(0,5),
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
