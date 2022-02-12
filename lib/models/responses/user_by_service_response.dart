import 'dart:convert';

import 'package:fixed_bids/models/user.dart';

UsersByServiceResponse usersByServiceResponseFromJson(String str) => UsersByServiceResponse.fromJson(json.decode(str));

String usersByServiceResponseToJson(UsersByServiceResponse data) => json.encode(data.toJson());

class UsersByServiceResponse {
  UsersByServiceResponse({
    this.status,
    this.code,
    this.message,
    this.items,
    this.isThereMore,
  });

  bool status;
  int code;
  String message;
  List<User> items;
  String isThereMore;

  factory UsersByServiceResponse.fromJson(Map<String, dynamic> json) => UsersByServiceResponse(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    items: List<User>.from(json["items"].map((x) => User.fromJson(x))),
    isThereMore: json["is_there_more"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "is_there_more": isThereMore,
  };
}
