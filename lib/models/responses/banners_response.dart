// To parse this JSON data, do
//
//     final bannersResponse = bannersResponseFromJson(jsonString);

import 'dart:convert';

BannersResponse bannersResponseFromJson(String str) => BannersResponse.fromJson(json.decode(str));

String bannersResponseToJson(BannersResponse data) => json.encode(data.toJson());

class BannersResponse {
  BannersResponse({
    this.status,
    this.code,
    this.message,
    this.items,
  });

  bool status;
  int code;
  String message;
  List<Item> items;

  factory BannersResponse.fromJson(Map<String, dynamic> json) => BannersResponse(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    this.id,
    this.type,
    this.status,
    this.image,
    this.link,
    this.serviceId,
    this.createdAt,
    this.details,
  });

  int id;
  int type;
  String status;
  String image;
  String link;
  int serviceId;
  DateTime createdAt;
  String details;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    type: json["type"],
    status: json["status"],
    image: json["image"],
    link: json["link"],
    serviceId: json["service_id"],
    createdAt: DateTime.parse(json["created_at"]),
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "status": status,
    "image": image,
    "link": link,
    "service_id": serviceId,
    "created_at": createdAt.toIso8601String(),
    "details": details,
  };
}
