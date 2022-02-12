class Service {
  Service({
    this.id,
    this.image,
    this.status,
    this.createdAt,
    this.name,
  });

  int id;
  String image;
  String status;
  DateTime createdAt;
  String name;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    image: json["image"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "name": name,
  };
}
