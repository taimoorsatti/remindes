import 'package:remindly_app/screens/newevent/components/textfield/new_event_textfield.dart';

class Upcoming {
  final String? ImageUrl;
  final String? type;
  final String? date;
  final String? heartIcon;

  Upcoming({this.type, this.date, this.heartIcon, this.ImageUrl});
}

class UpcomingModel {
 Map? contactMap;
  String? date;
  Map? repeatEventMap;
  String? note;
  String? reminders;
  String? title;
  bool? isfav;
  String? cat;
 String? iconUrl;
 String? jobId;
 String? eventId;
 String? nextdate;

  UpcomingModel(
      {
      this.date,
      this.title,
      this.contactMap,
      this.isfav,
        this.iconUrl,
        this.nextdate,
      this.note,
        this.jobId,
        this.eventId,
      this.reminders,
        this.repeatEventMap,
        this.cat,

     });

  UpcomingModel.fromJson(Map<String, dynamic> map) {
    contactMap=map["contact"];
    date=map["date"];
    repeatEventMap=map["repeatEvent"];
    title=map["title"];
    isfav=map["isFavorite"];
    note=map["note"];
    reminders=map["reminder"];
    cat=map["category"];
    nextdate=map["nextDate"];
    jobId=map["jobId"];
    eventId=map["eventID"];

  }
}
