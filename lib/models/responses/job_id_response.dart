
import 'dart:convert';

import 'package:fixed_bids/models/job.dart';

JobDetailsResponse jobDetailsResponseFromJson(String str) => JobDetailsResponse.fromJson(json.decode(str));

String jobDetailsResponseToJson(JobDetailsResponse data) => json.encode(data.toJson());

class JobDetailsResponse {
  JobDetailsResponse({
    this.status,
    this.code,
    this.message,
    this.item,
  });

  bool status;
  int code;
  String message;
  Job item;

  factory JobDetailsResponse.fromJson(Map<String, dynamic> json) => JobDetailsResponse(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    item: Job.fromJson(json["item"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "item": item.toJson(),
  };
}


