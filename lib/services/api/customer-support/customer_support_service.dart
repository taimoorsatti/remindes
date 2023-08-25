import 'dart:convert';

import 'package:remindly_app/services/api/network/network_utils.dart';

import '../../../models/addevent/add_event_model.dart';
import '../network/config.dart';

class CustomerSupportService {
  static Future<NotificationModel> saveCustomerSupport(
      {String? subject,
        required String content,
        required email}) async {
    // ignore: non_constant_identifier_names
    var Params = {
      "subject": "Hello World",
      "content": "This is a test email content.",
      "email": "recipient@example.com"
    };
    var response = await postRequest(ApiUrl.sendEmail, body: Params);
    if (response.statusCode == 200) {
      return NotificationModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}
