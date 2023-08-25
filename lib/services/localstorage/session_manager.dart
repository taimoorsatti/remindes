// ignore_for_file: file_names

import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class SessionKeys {
  static String theme = 'theme';
  static String fcmToken = 'fcmToken';
  static String loginUser = 'loginUser';
  static String riderID = 'riderID';
  static String cityID = 'riderId';
  static String anoID = 'anoId';
}

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() => _instance;

  SessionManager._internal();

  save(String key, value) {
    GetStorage().write(key, value);
  }

  readData(String key) {
    final data = GetStorage().read(key);
    return data != null ? json.decode(data) : null;
  }

  saveData(String key, value) {
    GetStorage().write(key, json.encode(value));
  }

  remove(String key) {
    GetStorage().remove(key);
  }

  containKey(String key) {
    final allKeys = GetStorage().getKeys();
    return allKeys.contains(key);
  }

  //=======================================================================
  //===================== Save Keys with values ===========================
  //=======================================================================

  saveFCMToken({String? token}) {
    saveData(SessionKeys.fcmToken, token);
  }

  saveRiderId({String? riderId}) {
    saveData(SessionKeys.riderID, riderId);
  }

  saveAnoId({String? anoId}) {
    saveData(SessionKeys.anoID, anoId);
  }


  // saveLoginUser({LoginModel loginUser}) =>
  //     save(SessionKeys.loginUser, loginUser);


  savecityId({String? cityID}) => saveData(SessionKeys.cityID, cityID);


  //=======================================================================
  //======================== Get Keys with values =========================
  //=======================================================================

  // ignore: todo
  //TODO: get Value from Session
  String? getToken() {
    if (containKey(SessionKeys.fcmToken)) {
      return readData(SessionKeys.fcmToken);
    }
    return null;
  }

  bool get isUserLogin {
    var isContain = containKey(SessionKeys.fcmToken);
    return isContain;
  }

  String get riderID{
    return readData(SessionKeys.riderID);
  }

  String get anoID{
    return readData(SessionKeys.anoID);
  }

  String get cityID {
    return readData(SessionKeys.cityID);
  }

  bool get isLightMode {
    return readData(SessionKeys.theme);
  }

  clearSession() {
    remove(SessionKeys.riderID);
    remove(SessionKeys.fcmToken);
    remove(SessionKeys.loginUser);
  }
}
