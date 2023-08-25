class NearestModel {
  Map? contactMap;
  String? date;
  Map? repeatEventMap;
  String? note;
  String? reminders;
  String? title;
  bool? isfav;
  String? cat;
  String? iconUrl;
  String? nextDate;
  String? jobId;
  String? lottieIcon;

  NearestModel(
      {
        this.date,
        this.title,
        this.nextDate,
        this.contactMap,
        this.isfav,
        this.iconUrl,
        this.lottieIcon,
        this.note,
        this.reminders,
        this.repeatEventMap,
        this.cat,
        this.jobId

      });

  NearestModel.fromJson(Map<String, dynamic> map) {
    contactMap=map["contact"];
    date=map["date"];
    repeatEventMap=map["repeatEvent"];
    title=map["title"];
    isfav=map["isFavorite"];
    note=map["note"];
    reminders=map["reminder"];
    cat=map["category"];
    jobId=map["jobId"];
    nextDate=map["nextDate"];

  }
}

class DialogModel {
  Map? contactMap;
  String? date;
  Map? repeatEventMap;
  String? note;
  String? reminders;
  String? title;
  bool? isfav;
  String? cat;
  String? iconUrl;
  String? nextDate;
  String? jobId;
  String? lottieIcon;

  DialogModel(
      {
        this.date,
        this.title,
        this.nextDate,
        this.contactMap,
        this.isfav,
        this.iconUrl,
        this.lottieIcon,
        this.note,
        this.reminders,
        this.repeatEventMap,
        this.cat,
        this.jobId

      });

  DialogModel.fromJson(Map<String, dynamic> map) {
    contactMap=map["contact"];
    date=map["date"];
    repeatEventMap=map["repeatEvent"];
    title=map["title"];
    isfav=map["isFavorite"];
    note=map["note"];
    reminders=map["reminder"];
    cat=map["category"];
    jobId=map["jobId"];
    nextDate=map["nextDate"];

  }
}