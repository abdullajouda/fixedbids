// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

import 'package:fixed_bids/models/user.dart';

ProfileResponse profileResponseFromJson(String str) => ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) => json.encode(data.toJson());

class ProfileResponse {
  ProfileResponse({
    this.status,
    this.code,
    this.message,
    this.item,
  });

  bool status;
  int code;
  String message;
  User item;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    item: User.fromJson(json["item"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "item": item.toJson(),
  };
}




