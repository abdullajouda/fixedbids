import 'dart:convert';
import 'package:fixed_bids/models/job.dart';

NearByJobsResponse nearByJobsResponseFromJson(String str) =>
    NearByJobsResponse.fromJson(json.decode(str));


class NearByJobsResponse {
  NearByJobsResponse({
    this.status,
    this.code,
    this.message,
    this.items,
    this.isThereMore,
  });

  bool status;
  int code;
  String message;
  List<Job> items;
  String isThereMore;

  factory NearByJobsResponse.fromJson(Map<String, dynamic> json) =>
      NearByJobsResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        items: json["items"] != null
            ? List<Job>.from(json["items"].map((x) => Job.fromJson(x)))
            : [],
        isThereMore: json["is_there_more"],
      );


}
