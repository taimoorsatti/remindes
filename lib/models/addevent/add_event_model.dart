class AddEventModel{
  final String? type;
  final String? iconUrl;
  final DateTime? date;
  AddEventModel({this.type,this.iconUrl,this.date});
}


class ModelAddEvent {
  Map? contactMap;
  String? date;
  Map? repeatEventMap;
  String? note;
  String? reminders;
  String? title;
  bool? isfav;
  String? cat;
  String? iconUrl;
  String? docId;

  ModelAddEvent(
      {
        this.date,
        this.title,
        this.contactMap,
        this.isfav,
        this.iconUrl,
        this.note,
        this.reminders,
        this.repeatEventMap,
        this.cat,
        this.docId

      });

  ModelAddEvent.fromJson(Map<String, dynamic> map) {
    contactMap=map["contact"];
    date=map["date"];
    repeatEventMap=map["repeatEvent"];
    title=map["title"];
    isfav=map["isFavourite"];
    note=map["note"];
    reminders=map["reminder"];
    cat=map["category"];
    this.docId=map["doc_Id"];

  }
}





class NotificationModel {
  bool? success;
  String? message;
  Job? job;

  NotificationModel({this.success, this.message, this.job});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    job = json['job'] != null ? new Job.fromJson(json['job']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.job != null) {
      data['job'] = this.job!.toJson();
    }
    return data;
  }
}

class Job {
  String? id;
  String? name;
  String? description;

  Job({this.id, this.name, this.description});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}



class DeleteModel {
  bool? success;
  String? message;

  DeleteModel({this.success, this.message});

  DeleteModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}