import 'package:flutter/material.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/widgets/account_page/check_in/check_in_chart_controller.dart';
import 'package:harmony/widgets/account_page/check_in/check_in_chunk.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class CheckInChart extends StatelessWidget {
  final HarmonyUser user;
  final CheckInChartController controller = CheckInChartController();
  CheckInChart(this.user, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    if(user.checkIns.length < 6){
      return getNoCheckInWidget();
    }else {
      return Expanded(
          child: getChartWidget()
      );
    }
  }

  Widget getNoCheckInWidget(){
    return const Text(
      "You need to have at least 5 check-ins to display a chart!",
      style: TextStyle(
          fontSize: 10
      ),
    );
  }

  Widget getChartWidget(){
    List<CheckInChunk> checkInChunks = controller.getChunks(user);
    return SfSparkLineChart.custom(
      marker: const SparkChartMarker(
          displayMode: SparkChartMarkerDisplayMode.last),
      //Enable data label
      labelDisplayMode: SparkChartLabelDisplayMode.none,
      xValueMapper: (int index) => index,
      yValueMapper: (int index) => checkInChunks[index].numOfCheckIns,
      dataCount: checkInChunks.length,
      lowPointColor: const Color(0XFFFCFFD4),
      highPointColor: kHarmonyColor,
      color: kHarmonyColor,
      axisLineColor: Colors.transparent,
    );
  }
}
