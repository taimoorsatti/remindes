import 'package:date_format/date_format.dart';
import 'package:remindly_app/screens/newevent/components/textfield/new_event_textfield.dart';



class SearchEventModel{
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

  SearchEventModel(
      {
        this.date,
        this.title,
        this.contactMap,
        this.isfav,
        this.iconUrl,
        this.note,
        this.jobId,
        this.eventId,
        this.reminders,
        this.repeatEventMap,
        this.cat,

      });

  SearchEventModel.fromJson(Map<String, dynamic> map) {
    contactMap=map["contact"];
    date=map["date"];
    repeatEventMap=map["repeatEvent"];
    title=map["title"];
    isfav=map["isFavorite"];
    note=map["note"];
    eventId=map["eventID"];
    reminders=map["reminder"];
    cat=map["category"];
    jobId=map["jobId"];

  }
}
