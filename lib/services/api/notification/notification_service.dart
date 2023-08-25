import 'dart:convert';

import 'package:remindly_app/services/api/network/network_utils.dart';

import '../../../models/addevent/add_event_model.dart';
import '../network/config.dart';

class NotificationService {
  static Future<NotificationModel> saveNotification(
      {String? title,
      required String text,
      required String userId,
      datetime,
        String? eventId,
      recurrence,
      isSmsSubscription}) async {
    // ignore: non_constant_identifier_names
    var Params = {
      "title": title,
      "text": text,
      "eventId":eventId,
      "userId": userId,
      "datetime": datetime,
      "recurrence": recurrence,
      "isSmsSubscription": isSmsSubscription,
    };
    var response = await postRequest(ApiUrl.sendNotification, body: Params);
    if (response.statusCode == 200) {
      return NotificationModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }



  static Future<DeleteModel> DeleteNotification(
      {String? id}) async {
    // ignore: non_constant_identifier_names
    var response = await deleteRequest(ApiUrl.deleteNotification+"${id}");
    if (response.statusCode == 200) {
      return DeleteModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}
