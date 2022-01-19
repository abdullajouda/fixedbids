// To parse this JSON data, do
//
//     final adsResponse = adsResponseFromJson(jsonString);

import 'dart:convert';

AdsResponse adsResponseFromJson(String str) => AdsResponse.fromJson(json.decode(str));

String adsResponseToJson(AdsResponse data) => json.encode(data.toJson());

class AdsResponse {
  AdsResponse({
    this.status,
    this.code,
    this.message,
    this.items,
  });

  bool status;
  int code;
  String message;
  List<Item> items;

  factory AdsResponse.fromJson(Map<String, dynamic> json) => AdsResponse(
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
    this.image,
    this.link,
    this.status,
    this.createdAt,
    this.details,
    this.title,
  });

  int id;
  String image;
  dynamic link;
  String status;
  DateTime createdAt;
  String details;
  String title;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    image: json["image"],
    link: json["link"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    details: json["details"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "link": link,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "details": details,
    "title": title,
  };
}
