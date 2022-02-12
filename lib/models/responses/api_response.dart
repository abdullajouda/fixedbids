class ApiResponse {
  bool status;
  int code;
  String message;
  dynamic response;
  dynamic isMore;
  dynamic url;
  dynamic chatID;

  ApiResponse(
      {this.status, this.code, this.message, this.response,this.url, this.chatID,this.isMore});

  factory ApiResponse.fromJson(Map<String, dynamic> json,
          {String key = '',
          dynamic Function(Map<String, dynamic> json) fun}) =>
      ApiResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        isMore: json["is_more"],
        url: json["url"],
        chatID: json["chat_id"],
        response: json[key] != null
            ? json[key] is List
                ? List<dynamic>.from(json[key].map((x) => fun(x)))
                : fun(json[key])
            : null,
      );
}
