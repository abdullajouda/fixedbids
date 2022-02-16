import 'package:flutter/material.dart';

class NotificationsController with ChangeNotifier {
  List<String> _onlineUsers =[];

  List<String> get onlineUsers => _onlineUsers;

  set onlineUsers(List<String> onlineUsers) {
    _onlineUsers = onlineUsers;
    notifyListeners();
  }

  resetOnlineUsers(){
    _onlineUsers.clear();
    notifyListeners();
  }

  updateOnlineUsers({String key}) {
    _onlineUsers.add(key);
    notifyListeners();
  }

  int _notificationCount = 0;

  int get notificationCount => _notificationCount;

  set notificationCount(int notificationCount) {
    _notificationCount = notificationCount;
    notifyListeners();
  }
}
