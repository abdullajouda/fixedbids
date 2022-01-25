import 'dart:async';

import 'package:fixed_bids/constants.dart';
import 'package:fixed_bids/models/responses/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController {
  static Future<SharedPreferencesController> _instance;
  static SharedPreferences _sharedPreferences;
  static Completer<SharedPreferencesController> _completer;

  SharedPreferencesController._();

  static Future<SharedPreferencesController> get instance async {
    if (_instance != null) return _instance;
    _completer = Completer<SharedPreferencesController>();
    await _init();
    _completer.complete(SharedPreferencesController._());
    return _instance = _completer.future;
  }

  static Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    print('SharedPreferences initiated !');
  }

  String getAppLang() {
    return _sharedPreferences.getString('language') ?? 'en';
  }

  Future<void> setAppLang(String lang) async {
    await _sharedPreferences.setString('language', lang);
  }

  Future<int> getAppLaunchTimes() async {
    return _sharedPreferences.getInt('launch_times');
  }

  Future<int> setAppLaunchTimes() async {
    int count = _sharedPreferences.getInt('launch_times');
    if (count != null) {
      count++;
    }
    await _sharedPreferences.setInt('launch_times', count ?? 1);
    return count;
  }

  bool getIsLogin() {
    return _sharedPreferences.getBool('is_login') ?? false;
  }

  Future<void> setIsLogin(bool isLogin) async {
    await _sharedPreferences.setBool('is_login', isLogin);
  }

  User getUserData() {
    return userFromJson(
      _sharedPreferences.getString('user'),
    );
  }

  Future<void> setUserData(User user) async {
    await _sharedPreferences.setString(
      'user',
      user == null ? null : userToJson(user),
    );
  }

  Future<void> setIsNotificationsEnabled(bool value) async {
    return _sharedPreferences.setBool('is_notification_enabled', value);
  }

  bool isNotificationsEnabled() {
    return _sharedPreferences.getBool('is_notification_enabled') ?? true;
  }

  Future<void> clear() async {
    await _sharedPreferences.clear();
  }

  Future<void> clearUserData() async {
    await setIsLogin(false);
    await setUserData(null);
    Data.currentUser = null;
  }
}
