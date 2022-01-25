// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

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

class User {
  User({
    this.id,
    this.restaurantApiId,
    this.name,
    this.email,
    this.mobile,
    this.imageProfile,
    this.cityId,
    this.rememberToken,
    this.status,
    this.type,
    this.address,
    this.zipCode,
    this.latitude,
    this.longitude,
    this.priceFrom,
    this.priceTo,
    this.isVerified,
    this.verifiedToken,
    this.totalFollowers,
    this.totalFollowings,
    this.completeJobCount,
    this.rate,
    this.accessToken,
    this.servises,
  });

  int id;
  dynamic restaurantApiId;
  String name;
  String email;
  String mobile;
  String imageProfile;
  dynamic cityId;
  dynamic rememberToken;
  String status;
  String type;
  String address;
  String zipCode;
  String latitude;
  String longitude;
  dynamic priceFrom;
  dynamic priceTo;
  int isVerified;
  dynamic verifiedToken;
  int totalFollowers;
  int totalFollowings;
  int completeJobCount;
  int rate;
  String accessToken;
  List<dynamic> servises;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    restaurantApiId: json["restaurant_api_id"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    imageProfile: json["image_profile"],
    cityId: json["city_id"],
    rememberToken: json["remember_token"],
    status: json["status"],
    type: json["type"],
    address: json["address"],
    zipCode: json["zip_code"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    priceFrom: json["price_from"],
    priceTo: json["price_to"],
    isVerified: json["is_verified"],
    verifiedToken: json["verified_token"],
    totalFollowers: json["total_followers"],
    totalFollowings: json["total_followings"],
    completeJobCount: json["complete_job_count"],
    rate: json["rate"],
    accessToken: json["access_token"],
    servises: List<dynamic>.from(json["servises"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "restaurant_api_id": restaurantApiId,
    "name": name,
    "email": email,
    "mobile": mobile,
    "image_profile": imageProfile,
    "city_id": cityId,
    "remember_token": rememberToken,
    "status": status,
    "type": type,
    "address": address,
    "zip_code": zipCode,
    "latitude": latitude,
    "longitude": longitude,
    "price_from": priceFrom,
    "price_to": priceTo,
    "is_verified": isVerified,
    "verified_token": verifiedToken,
    "total_followers": totalFollowers,
    "total_followings": totalFollowings,
    "complete_job_count": completeJobCount,
    "rate": rate,
    "access_token": accessToken,
    "servises": List<dynamic>.from(servises.map((x) => x)),
  };
}
