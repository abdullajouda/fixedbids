import 'package:fixed_bids/models/user.dart';

class NotificationModel {
  NotificationModel({
    this.id,
    this.userId,
    this.orderId,
    this.messages,
    this.messagType,
    this.fromUserId,
    this.toUserId,
    this.seen,
    this.status,
    this.createdAt,
    this.message,
    this.message1,
    this.message2,
    this.coloredMessage,
    this.fromUser,
  });

  int id;
  int userId;
  int orderId;
  dynamic messages;
  String messagType;
  int fromUserId;
  int toUserId;
  int seen;
  String status;
  DateTime createdAt;
  String message;
  String message1;
  String message2;
  String coloredMessage;
  User fromUser;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["id"],
    userId: json["user_id"],
    orderId: json["order_id"],
    messages: json["messages"],
    messagType: json["messag_type"],
    fromUserId: json["from_user_id"],
    toUserId: json["to_user_id"],
    seen: json["seen"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    message: json["message"],
    message1: json["message1"] == null ? null : json["message1"],
    message2: json["message2"] == null ? null : json["message2"],
    coloredMessage: json["colored_message"] == null ? null : json["colored_message"],
    fromUser: User.fromJson(json["from_user"]),
  );


}

class Translation {
  Translation({
    this.id,
    this.notifiyId,
    this.locale,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  int notifiyId;
  String locale;
  String message;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    id: json["id"],
    notifiyId: json["notifiy_id"],
    locale: json["locale"],
    message: json["message"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );


}