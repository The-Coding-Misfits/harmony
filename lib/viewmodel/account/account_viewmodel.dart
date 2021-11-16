import 'package:harmony/models/associative_entities/check_in.dart';
import 'package:harmony/models/user.dart';

class AccountPageViewModel {

  List<CheckIn> getCheckIns(HarmonyUser user){
    List<CheckIn> checkIns = user.checkIns;
    sortCheckInsByTime(checkIns);
    return checkIns;
  }
  void sortCheckInsByTime(List<CheckIn> checkIns){
    checkIns.sort(
      compareTwoCheckIns
    );
  }

  int compareTwoCheckIns(CheckIn firstCheckIn, CheckIn secondCheckIn){
    return firstCheckIn.compareTo(secondCheckIn);
  }

}


