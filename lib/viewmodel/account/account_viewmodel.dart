import 'package:harmony/models/associative_entities/check_in.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/viewmodel/account/check_in_week_representation.dart';

class AccountPageViewModel {

  List<CheckInWeekRepresentation> getCheckInsByWeek(){

  }


  List<CheckIn> _getCheckIns(HarmonyUser user){
    List<CheckIn> checkIns = user.checkIns;
    _sortCheckInsByTime(checkIns);
    return checkIns;
  }
  void _sortCheckInsByTime(List<CheckIn> checkIns){
    checkIns.sort(
        _compareTwoCheckIns
    );
  }

  int _compareTwoCheckIns(CheckIn firstCheckIn, CheckIn secondCheckIn){
    return firstCheckIn.compareTo(secondCheckIn);
  }

}


