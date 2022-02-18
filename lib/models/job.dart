import 'package:fixed_bids/models/service.dart';
import 'package:fixed_bids/models/user.dart';

class Job {
  Job({
    this.id,
    this.userId,
    this.serviceId,
    this.title,
    this.price,
    this.details,
    this.zipCode,
    this.urgencyType,
    this.latitude,
    this.longitude,
    this.image,
    this.status,
    this.isOpen,
    this.providerId,
    this.isApproved,
    this.createdAt,
    this.distance,
    this.user,
    this.provider,
    this.service,
    this.attachments,
  });

  int id;
  int userId;
  int serviceId;
  String title;
  double price;
  String details;
  String zipCode;
  int urgencyType;
  String latitude;
  String longitude;
  String image;
  dynamic status;
  int isOpen;
  int providerId;
  int isApproved;
  DateTime createdAt;
  double distance;
  User user;
  User provider;
  Service service;
  List<Attachment> attachments;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        userId: json["user_id"],
        serviceId: json["service_id"],
        title: json["title"],
        price: json["price"] != null
            ? double.parse(json["price"].toString())
            : null,
        details: json["details"],
        zipCode: json["zip_code"],
        urgencyType: json["urgency_type"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        image: json["image"],
        status: json["status"],
        isOpen: json["is_open"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        isApproved: json["is_approved"],
        createdAt: DateTime.parse(json["created_at"]),
        distance: json["distance"] != null
            ? double.parse(json["distance"].toString())
            : null,
        user: User.fromJson(json["user"]),
        provider:
            json["provider"] != null ? User.fromJson(json["provider"]) : null,
        service:
            json["service"] != null ? Service.fromJson(json["service"]) : null,
        attachments: json["attachments"] != null
            ? List<Attachment>.from(
                json["attachments"].map((x) => Attachment.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "service_id": serviceId,
        "title": title,
        "price": price,
        "details": details,
        "zip_code": zipCode,
        "urgency_type": urgencyType,
        "latitude": latitude,
        "longitude": longitude,
        "image": image,
        "status": status,
        "is_open": isOpen,
        "provider_id": providerId == null ? null : providerId,
        "is_approved": isApproved,
        "created_at": createdAt.toIso8601String(),
        "distance": distance,
        "user": user.toJson(),
        "service": service.toJson(),
      };
}

class Attachment {
  Attachment({
    this.id,
    this.jobId,
    this.image,
    this.createdAt,
  });

  int id;
  int jobId;
  String image;
  DateTime createdAt;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        jobId: json["job_id"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_id": jobId,
        "image": image,
        "created_at": createdAt.toIso8601String(),
      };
}
