import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harmony/models/associative_entities/check_in.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/viewmodel/account/check_in_chunk.dart';

class AccountPageViewModel {

  List<CheckInChunk> getCheckInsByWeek(HarmonyUser user){
    List<CheckIn> checkIns = _getCheckIns(user);
    if(checkIns.isEmpty) return [];

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


  List<CheckInChunk> getChunks(List<CheckIn> checkIns){




  }

  List<Timestamp> divideTheCheckInTimeFrame(List<CheckIn> checkIns){
    const NUM_DIVISIONS_TIMEFRAME = 15;
    Timestamp firstCheckInTime = checkIns.first.time;
    Timestamp lastCheckInTime = checkIns.last.time;
    return pointChunks(NUM_DIVISIONS_TIMEFRAME, firstCheckInTime, lastCheckInTime);
  }

  List<Timestamp> pointChunks(int NUM_DIVISIONS_TIMEFRAME,Timestamp firstCheckInTime, Timestamp lastCheckInTime ){
    int totalSecondsBetweenCheckins = lastCheckInTime.seconds - firstCheckInTime.seconds;
    int oneChunkTime = totalSecondsBetweenCheckins ~/ NUM_DIVISIONS_TIMEFRAME;
    List<Timestamp> timeChunks = [];
    for(int i = 1; i <= NUM_DIVISIONS_TIMEFRAME; i++){
      int timeOfChunk = firstCheckInTime.seconds + (oneChunkTime * i);
      timeChunks.add(
        Timestamp(timeOfChunk, 0)
      );
    }
    return timeChunks;

  }






}


