// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:fixed_bids/models/service.dart';
import 'package:fixed_bids/models/user.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.status,
    this.code,
    this.user,
    this.message,
  });

  bool status;
  int code;
  String message;
  User user;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    user:json["user"]!=null? User.fromJson(json["user"]):null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "user": user.toJson(),
  };
}


User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());


class Servise {
  Servise({
    this.id,
    this.userId,
    this.serviceId,
    this.createdAt,
    this.service,
  });

  int id;
  int userId;
  int serviceId;
  DateTime createdAt;
  Service service;

  factory Servise.fromJson(Map<String, dynamic> json) => Servise(
    id: json["id"],
    userId: json["user_id"],
    serviceId: json["service_id"],
    createdAt: DateTime.parse(json["created_at"]),
    service: Service.fromJson(json["service"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "service_id": serviceId,
    "created_at": createdAt.toIso8601String(),
    "service": service.toJson(),
  };
}
