import 'dart:convert';

import 'package:fixed_bids/models/notification.dart';

NotificationsResponse notificationsResponseFromJson(String str) =>
    NotificationsResponse.fromJson(json.decode(str));

class NotificationsResponse {
  NotificationsResponse({
    this.status,
    this.code,
    this.message,
    this.items,
    this.isThereMore,
  });

  bool status;
  int code;
  String message;
  List<NotificationModel> items;
  String isThereMore;

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      NotificationsResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        items: json["items"] == null
            ? null
            : List<NotificationModel>.from(
                json["items"].map((x) => NotificationModel.fromJson(x))),
        isThereMore: json["is_there_more"],
      );
}
