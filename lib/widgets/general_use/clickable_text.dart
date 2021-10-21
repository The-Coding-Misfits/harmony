import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final Function() onPress;
  final Text textWidget;


  ClickableText({required this.onPress, required this.textWidget});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: textWidget,
    );
  }
}
