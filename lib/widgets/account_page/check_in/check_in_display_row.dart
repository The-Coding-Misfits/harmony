import 'package:flutter/material.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/widgets/account_page/check_in/check_in_chart.dart';

class CheckInDisplayRow extends StatelessWidget {
  final HarmonyUser user;
  const CheckInDisplayRow(this.user);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            fit: FlexFit.loose,
            flex: 1,
            child: getCheckInCountText(),
          ),
          Flexible(
            fit: FlexFit.loose,
            flex: 2,
            child: CheckInChart(user),
          )
        ],
      ),
    );
  }


  Widget getCheckInCountText(){
    return Column(
      children: [
        const Text(
          "CHECK-INS",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 10
          ),
        ),
        Text(
          "${user.checkIns.length}",
          style: const TextStyle(
            color : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15
          ),
        ),
      ],
    );
  }
}
