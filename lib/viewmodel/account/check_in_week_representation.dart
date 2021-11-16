import 'package:cloud_firestore/cloud_firestore.dart';

class CheckInWeekRepresentation{
  Timestamp includeBeginTime;
  Timestamp includeEndTime;

  CheckInWeekRepresentation(this.includeBeginTime, this.includeEndTime);


}