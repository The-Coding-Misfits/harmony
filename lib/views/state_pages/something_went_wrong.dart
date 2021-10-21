import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "OOPS!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
        SizedBox(
          height: 30,
          width: 10,
        ),
        Text(
          "Something went wrong, please try again later",
          style: TextStyle(
            fontSize: 20,
          ),
        )
      ],
    );
  }
}
