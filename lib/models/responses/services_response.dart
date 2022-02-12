// To parse this JSON data, do
//
//     final servicesResponse = servicesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:fixed_bids/models/service.dart';

ServicesResponse servicesResponseFromJson(String str) => ServicesResponse.fromJson(json.decode(str));

String servicesResponseToJson(ServicesResponse data) => json.encode(data.toJson());

class ServicesResponse {
  ServicesResponse({
    this.status,
    this.code,
    this.message,
    this.items,
  });

  bool status;
  int code;
  String message;
  List<Service> items;

  factory ServicesResponse.fromJson(Map<String, dynamic> json) => ServicesResponse(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    items: List<Service>.from(json["items"].map((x) => Service.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

