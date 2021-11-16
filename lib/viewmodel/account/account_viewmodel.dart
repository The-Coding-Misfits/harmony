import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harmony/models/associative_entities/check_in.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/viewmodel/account/check_in_chunk.dart';

class AccountPageViewModel {

  List<CheckInChunk> getChunks(HarmonyUser user){
    List<CheckIn> checkIns = _getCheckIns(user);
    if(checkIns.isEmpty) return [];
    List<Timestamp> chunkStartTimestamps = divideTheCheckInTimeFrame(checkIns);
    return sortCheckInsToChunks(chunkStartTimestamps, checkIns);
  }

  List<CheckIn> _getCheckIns(HarmonyUser user){
    List<CheckIn> checkIns = user.checkIns;
    checkIns = _sortCheckInsByTime(checkIns);
    return checkIns;
  }
  List<CheckIn> _sortCheckInsByTime(List<CheckIn> checkIns){
    checkIns.sort(
        _compareTwoCheckIns
    );
    //checkIns = checkIns.reversed as List<CheckIn>; // since we compare if bigger
    print(checkIns);
    return checkIns;
  }

  int _compareTwoCheckIns(CheckIn firstCheckIn, CheckIn secondCheckIn){
    return firstCheckIn.compareTo(secondCheckIn);
  }

  List<Timestamp> divideTheCheckInTimeFrame(List<CheckIn> checkIns){
    const NUM_DIVISIONS_TIMEFRAME = 15;
    Timestamp firstCheckInTime = checkIns.first.time;
    Timestamp lastCheckInTime = checkIns.last.time;
    return getTheChunkStartTimeStamps(NUM_DIVISIONS_TIMEFRAME, firstCheckInTime, lastCheckInTime);
  }

  List<Timestamp> getTheChunkStartTimeStamps(int NUM_DIVISIONS_TIMEFRAME,Timestamp firstCheckInTime, Timestamp lastCheckInTime ){
    int totalSecondsBetweenCheckins = lastCheckInTime.seconds - firstCheckInTime.seconds;
    int oneChunkTime = totalSecondsBetweenCheckins ~/ NUM_DIVISIONS_TIMEFRAME;
    List<Timestamp> timeChunks = [];
    for(int i = 0; i < NUM_DIVISIONS_TIMEFRAME; i++){
      int timeOfChunk = firstCheckInTime.seconds + (oneChunkTime * i);
      timeChunks.add(
        Timestamp(timeOfChunk, 0)
      );
    }
    return timeChunks;

  }

  List<CheckInChunk> sortCheckInsToChunks(List<Timestamp> chunkStartTimestamps, List<CheckIn> checkIns){
    List<CheckInChunk> checkInChunks = [];
    int numberOfPointsInChunk = 0;
    int currIndexOfTimestamps = 1;// start from second time stamp since we are checking smaller
    for(int i = 0; i < checkIns.length; i++){
      Timestamp nextChunkStartTimeStamp = chunkStartTimestamps[currIndexOfTimestamps];
      CheckIn checkIn = checkIns[i];
      int comparisonResult = checkIn.time.compareTo(nextChunkStartTimeStamp);
      if (comparisonResult == -1){//meaning checkIn time is smaller than next time stamp and belongs to this chunk
        numberOfPointsInChunk++;
      }
      else if(comparisonResult == 1  || comparisonResult == 0){ //meaning checkIn time is bigger or equal to the next timestamp therefore belongs to next chunk
        try{
          nextChunkStartTimeStamp = chunkStartTimestamps[currIndexOfTimestamps++];
          CheckInChunk chunkResolved = CheckInChunk(numberOfPointsInChunk);
          checkInChunks.add(chunkResolved);
          numberOfPointsInChunk = 0;
          i--; //since we want to loop again with this check in
        }catch(_){
          //catches for out of bounds exception in line 67
          //if there are no more time chunks meaning this is the last chunk
          numberOfPointsInChunk = checkIns.getRange(i, checkIns.length).length;
          CheckInChunk chunkResolved = CheckInChunk(numberOfPointsInChunk);
          checkInChunks.add(chunkResolved);
          break;
        }
      }
    }
    return checkInChunks;
  }






}


