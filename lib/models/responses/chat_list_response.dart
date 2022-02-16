

import 'dart:convert';

import 'package:fixed_bids/models/user.dart';

ChatListResponse chatListResponseFromJson(String str) => ChatListResponse.fromJson(json.decode(str));

String chatListResponseToJson(ChatListResponse data) => json.encode(data.toJson());

class ChatListResponse {
  ChatListResponse({
    this.status,
    this.code,
    this.message,
    this.chats,
  });

  bool status;
  int code;
  String message;
  Chats chats;

  factory ChatListResponse.fromJson(Map<String, dynamic> json) => ChatListResponse(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    chats: Chats.fromJson(json["chats"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "chats": chats.toJson(),
  };
}

class Chats {
  Chats({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<ChatHead> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Chats.fromJson(Map<String, dynamic> json) => Chats(
    currentPage: json["current_page"],
    data: List<ChatHead>.from(json["data"].map((x) => ChatHead.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class ChatHead {
  ChatHead({
    this.id,
    this.userId,
    this.type,
    this.lastUsed,
    this.createdAt,
    this.user,
    this.lastMessage,
  });

  int id;
  int userId;
  int type;
  DateTime lastUsed;
  DateTime createdAt;
  User user;
  LastMessage lastMessage;

  factory ChatHead.fromJson(Map<String, dynamic> json) => ChatHead(
    id: json["id"],
    userId: json["user_id"],
    type: json["type"],
    lastUsed: DateTime.parse(json["last_used"]),
    createdAt: DateTime.parse(json["created_at"]),
    user: User.fromJson(json["user"]),
    lastMessage: LastMessage.fromJson(json["last_message"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "type": type,
    "last_used": lastUsed.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "user": user.toJson(),
    "last_message": lastMessage.toJson(),
  };
}

class LastMessage {
  LastMessage({
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

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
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


class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String url;
  dynamic label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] == null ? null : json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url == null ? null : url,
    "label": label,
    "active": active,
  };
}
