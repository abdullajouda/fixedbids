// To parse this JSON data, do
//
//     final settingsResponse = settingsResponseFromJson(jsonString);

import 'dart:convert';

SettingsResponse settingsResponseFromJson(String str) => SettingsResponse.fromJson(json.decode(str));

String settingsResponseToJson(SettingsResponse data) => json.encode(data.toJson());

class SettingsResponse {
  SettingsResponse({
    this.status,
    this.code,
    this.message,
    this.settings,
  });

  bool status;
  int code;
  String message;
  Settings settings;

  factory SettingsResponse.fromJson(Map<String, dynamic> json) => SettingsResponse(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    settings: Settings.fromJson(json["settings"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "settings": settings.toJson(),
  };
}

class Settings {
  Settings({
    this.id,
    this.url,
    this.logo,
    this.taxAmount,
    this.pointsInMony,
    this.monyInPoints,
    this.appStoreUrl,
    this.playStoreUrl,
    this.infoEmail,
    this.mobile,
    this.phone,
    this.facebook,
    this.twitter,
    this.linkedIn,
    this.instagram,
    this.googlePlus,
    this.minOrder,
    this.fromHour,
    this.toHour,
    this.latitude,
    this.longitude,
    this.youtube,
    this.image,
    this.paginateTotal,
    this.adminCommissionParcent,
    this.isMaintenanceMode,
    this.isAlowedRegister,
    this.isAlowedLogin,
    this.isAlowedBuying,
    this.isAlowedCart,
    this.accountNeedToActivate,
    this.createdAt,
    this.updatedAt,
    this.pages,
    this.serverTime,
    this.title,
    this.joinDescription,
    this.description,
    this.address,
    this.keyWords,
  });

  int id;
  String url;
  String logo;
  int taxAmount;
  int pointsInMony;
  int monyInPoints;
  String appStoreUrl;
  String playStoreUrl;
  String infoEmail;
  String mobile;
  String phone;
  String facebook;
  String twitter;
  String linkedIn;
  String instagram;
  String googlePlus;
  int minOrder;
  String fromHour;
  String toHour;
  String latitude;
  String longitude;
  String youtube;
  String image;
  int paginateTotal;
  int adminCommissionParcent;
  int isMaintenanceMode;
  int isAlowedRegister;
  int isAlowedLogin;
  int isAlowedBuying;
  int isAlowedCart;
  int accountNeedToActivate;
  dynamic createdAt;
  DateTime updatedAt;
  List<Page> pages;
  DateTime serverTime;
  String title;
  dynamic joinDescription;
  String description;
  String address;
  dynamic keyWords;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    id: json["id"],
    url: json["url"],
    logo: json["logo"],
    taxAmount: json["tax_amount"],
    pointsInMony: json["points_in_mony"],
    monyInPoints: json["mony_in_points"],
    appStoreUrl: json["app_store_url"],
    playStoreUrl: json["play_store_url"],
    infoEmail: json["info_email"],
    mobile: json["mobile"],
    phone: json["phone"],
    facebook: json["facebook"],
    twitter: json["twitter"],
    linkedIn: json["linked_in"],
    instagram: json["instagram"],
    googlePlus: json["google_plus"],
    minOrder: json["min_order"],
    fromHour: json["from_hour"],
    toHour: json["to_hour"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    youtube: json["youtube"],
    image: json["image"],
    paginateTotal: json["paginateTotal"],
    adminCommissionParcent: json["admin_commission_parcent"],
    isMaintenanceMode: json["is_maintenance_mode"],
    isAlowedRegister: json["is_alowed_register"],
    isAlowedLogin: json["is_alowed_login"],
    isAlowedBuying: json["is_alowed_buying"],
    isAlowedCart: json["is_alowed_cart"],
    accountNeedToActivate: json["account_need_to_activate"],
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
    pages: List<Page>.from(json["pages"].map((x) => Page.fromJson(x))),
    serverTime: DateTime.parse(json["server_time"]),
    title: json["title"],
    joinDescription: json["join_description"],
    description: json["description"],
    address: json["address"],
    keyWords: json["key_words"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "logo": logo,
    "tax_amount": taxAmount,
    "points_in_mony": pointsInMony,
    "mony_in_points": monyInPoints,
    "app_store_url": appStoreUrl,
    "play_store_url": playStoreUrl,
    "info_email": infoEmail,
    "mobile": mobile,
    "phone": phone,
    "facebook": facebook,
    "twitter": twitter,
    "linked_in": linkedIn,
    "instagram": instagram,
    "google_plus": googlePlus,
    "min_order": minOrder,
    "from_hour": fromHour,
    "to_hour": toHour,
    "latitude": latitude,
    "longitude": longitude,
    "youtube": youtube,
    "image": image,
    "paginateTotal": paginateTotal,
    "admin_commission_parcent": adminCommissionParcent,
    "is_maintenance_mode": isMaintenanceMode,
    "is_alowed_register": isAlowedRegister,
    "is_alowed_login": isAlowedLogin,
    "is_alowed_buying": isAlowedBuying,
    "is_alowed_cart": isAlowedCart,
    "account_need_to_activate": accountNeedToActivate,
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
    "pages": List<dynamic>.from(pages.map((x) => x.toJson())),
    "server_time": serverTime.toIso8601String(),
    "title": title,
    "join_description": joinDescription,
    "description": description,
    "address": address,
    "key_words": keyWords,
  };
}

class Page {
  Page({
    this.id,
    this.image,
    this.views,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.title,
    this.description,
    this.keyWords,
    this.translations,
  });

  int id;
  String image;
  int views;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String title;
  String description;
  dynamic keyWords;
  List<Translation> translations;

  factory Page.fromJson(Map<String, dynamic> json) => Page(
    id: json["id"],
    image: json["image"],
    views: json["views"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    title: json["title"],
    description: json["description"],
    keyWords: json["key_words"],
    translations: List<Translation>.from(json["translations"].map((x) => Translation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "views": views,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "title": title,
    "description": description,
    "key_words": keyWords,
    "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
  };
}

class Translation {
  Translation({
    this.id,
    this.pageId,
    this.locale,
    this.title,
    this.slug,
    this.description,
    this.keyWords,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  int pageId;
  String locale;
  String title;
  String slug;
  String description;
  dynamic keyWords;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    id: json["id"],
    pageId: json["page_id"],
    locale: json["locale"],
    title: json["title"],
    slug: json["slug"],
    description: json["description"],
    keyWords: json["key_words"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "page_id": pageId,
    "locale": locale,
    "title": title,
    "slug": slug,
    "description": description,
    "key_words": keyWords,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
