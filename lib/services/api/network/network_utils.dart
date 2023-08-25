import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import '../../localstorage/session_manager.dart';
import 'config.dart';


Future<Response> postRequest(String endPoint, {dynamic body}) async {

  SessionManager _s=SessionManager();
  try {
    String url = "$baseURL$endPoint";
    log('API URL: POST $url  $body');
    Response response = await post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
      },
      body:jsonEncode(body),
    ).timeout(
      const Duration(seconds: timeoutDuration),
      onTimeout: (() => throw "Please try again"),
    );
    log('Response: ${response.statusCode} $url');
    return response;
  } catch (e) {
    log(e.toString());
    throw "Please try again";
  }
}


Future<Response> getRequest(String endPoint) async {
  SessionManager _s = SessionManager();
  try {
    String url = '$baseURL$endPoint';
    log(url);
    Response response = await get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        'Authorization': 'Bearer ${_s.getToken()}'
      },
    ).timeout(
       const Duration(seconds: timeoutDuration),
      onTimeout: (() => throw "Please try again"),
    );
    log('Code: ${response.statusCode} $url');
    return response;
  } catch (e) {
    log(e.toString());
    throw "Please try again";
  }
}


Future<Response> deleteRequest(String endPoint,) async {

  SessionManager _s=SessionManager();
  try {
    String url = "$baseURL$endPoint";
    Response response = await delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
      },
    ).timeout(
      const Duration(seconds: timeoutDuration),
      onTimeout: (() => throw "Please try again"),
    );
    log('Response: ${response.statusCode} $url');
    return response;
  } catch (e) {
    log(e.toString());
    throw "Please try again";
  }
}

