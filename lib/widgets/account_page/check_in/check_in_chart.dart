import 'package:flutter/cupertino.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/widgets/account_page/check_in/check_in_chart_controller.dart';
import 'package:harmony/widgets/account_page/check_in/check_in_chunk.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class CheckInChart extends StatelessWidget {
  final HarmonyUser user;
  final CheckInChartController controller = CheckInChartController();
  late final List<CheckInChunk> checkInChunks = controller.getChunks(user);
  CheckInChart(this.user, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    if(checkInChunks.isEmpty){
      return getNoCheckInWidget();
    }else {
      return getChartWidget();
    }
  }

  Widget getNoCheckInWidget(){
    return const Padding(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "You haven't checked in yet!",
          style: TextStyle(
              fontSize: 13
          ),
        ),
      ),
    );
  }

  Widget getChartWidget(){
    return SfSparkLineChart.custom(
    //Enable marker
      trackball: const SparkChartTrackball(

      ),
      marker: const SparkChartMarker(
          displayMode: SparkChartMarkerDisplayMode.none),
      //Enable data label
      labelDisplayMode: SparkChartLabelDisplayMode.none,
      xValueMapper: (int index) => index,
      yValueMapper: (int index) => checkInChunks[index].numOfCheckIns,
      dataCount: checkInChunks.length,
    );
  }
}
