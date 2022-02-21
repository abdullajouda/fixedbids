import 'package:fixed_bids/models/responses/login_response.dart';

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
    this.reviews,
    this.avgRate,
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
  String avgRate;
  String accessToken;
  List<Servise> servises;
  List<Review> reviews;

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
        avgRate: json["avg_rate"].toString(),
        accessToken: json["access_token"],
        servises: json["servises"] != null
            ? List<Servise>.from(
                json["servises"].map((x) => Servise.fromJson(x)))
            : null,
        reviews: json["reviews"] == null
            ? null
            : List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
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
        "servises": servises != null
            ? List<Servise>.from(servises.map((x) => x))
            : null,
      };
}

class Review {
  Review({
    this.id,
    this.userId,
    this.providerId,
    this.rate,
    this.comment,
    this.jobId,
    this.offerId,
    this.createdAt,
    this.user,
  });

  int id;
  int userId;
  int providerId;
  int rate;
  String comment;
  int jobId;
  int offerId;
  DateTime createdAt;
  User user;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["user_id"],
        providerId: json["provider_id"],
        rate: json["rate"],
        comment: json["comment"],
        jobId: json["job_id"],
        offerId: json["offer_id"],
        createdAt: DateTime.parse(json["created_at"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "provider_id": providerId,
        "rate": rate,
        "comment": comment,
        "job_id": jobId,
        "offer_id": offerId,
        "created_at": createdAt.toIso8601String(),
        "user": user.toJson(),
      };
}
