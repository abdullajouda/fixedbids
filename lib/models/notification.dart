class NotificationModel {
  NotificationModel({
    this.id,
    this.userId,
    this.orderId,
    this.messages,
    this.messagType,
    this.fromUserId,
    this.toUserId,
    this.status,
    this.createdAt,
    this.message,
    this.translations,
  });

  int id;
  int userId;
  int orderId;
  dynamic messages;
  String messagType;
  int fromUserId;
  int toUserId;
  String status;
  DateTime createdAt;
  String message;
  List<Translation> translations;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["id"],
    userId: json["user_id"],
    orderId: json["order_id"],
    messages: json["messages"],
    messagType: json["messag_type"],
    fromUserId: json["from_user_id"],
    toUserId: json["to_user_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    message: json["message"],
    translations: List<Translation>.from(json["translations"].map((x) => Translation.fromJson(x))),
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