// To parse this JSON data, do
//
//     final questionsResponse = questionsResponseFromJson(jsonString);

import 'dart:convert';

QuestionsResponse questionsResponseFromJson(String str) => QuestionsResponse.fromJson(json.decode(str));

String questionsResponseToJson(QuestionsResponse data) => json.encode(data.toJson());

class QuestionsResponse {
  QuestionsResponse({
    this.status,
    this.code,
    this.message,
    this.items,
  });

  bool status;
  int code;
  String message;
  List<Item> items;

  factory QuestionsResponse.fromJson(Map<String, dynamic> json) => QuestionsResponse(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    this.id,
    this.status,
    this.createdAt,
    this.question,
    this.answer,
  });

  int id;
  String status;
  DateTime createdAt;
  String question;
  String answer;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    question: json["question"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "question": question,
    "answer": answer,
  };
}
