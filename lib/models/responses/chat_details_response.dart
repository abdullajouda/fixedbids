import 'dart:convert';
import 'package:fixed_bids/models/user.dart';

ChatDetailsResponse chatDetailsResponseFromJson(String str) => ChatDetailsResponse.fromJson(json.decode(str));


class ChatDetailsResponse {
  ChatDetailsResponse({
    this.status,
    this.code,
    this.message,
    this.messages,
    this.user,
  });

  bool status;
  int code;
  String message;
  Messages messages;
  User user;

  factory ChatDetailsResponse.fromJson(Map<String, dynamic> json) => ChatDetailsResponse(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    messages: Messages.fromJson(json["messages"]),
    user: User.fromJson(json["user"]),
  );


}

class Messages {
  Messages({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Message> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
    currentPage: json["current_page"],
    data: List<Message>.from(json["data"].map((x) => Message.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

}

class Message {
  Message({
    this.id,
    this.chatId,
    this.senderId,
    this.text,
    this.type,
    this.durationTime,
    this.filename,
    this.latitude,
    this.longitude,
    this.seen,
    this.createdAt,
  });

  int id;
  int chatId;
  int senderId;
  String text;
  int type;
  int durationTime;
  String filename;
  dynamic latitude;
  dynamic longitude;
  int seen;
  DateTime createdAt;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    chatId: json["chat_id"],
    senderId: json["sender_id"],
    text: json["text"],
    type: json["type"],
    durationTime: json["duration_time"],
    filename: json["filename"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    seen: json["seen"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "chat_id": chatId,
    "sender_id": senderId,
    "text": text,
    "type": type,
    "duration_time": durationTime,
    "filename": filename,
    "latitude": latitude,
    "longitude": longitude,
    "seen": seen,
    "created_at": createdAt.toIso8601String(),
  };
}


