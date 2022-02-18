import 'dart:convert';
import 'dart:io';
import 'package:fixed_bids/models/responses/chat_details_response.dart';
import 'package:http/http.dart';
import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/models/responses/api_response.dart';
import 'package:fixed_bids/models/responses/chat_list_response.dart';
import 'package:async/async.dart';

class ChatController {
  Future<ChatListResponse> getChatList({String search = ''}) async {
    var request = await get(
      Uri.parse("${Constants.domain}chatsList?userName=$search"),
      headers: Constants().headers,
    );
    var output = json.decode(request.body);
    ChatListResponse response = ChatListResponse.fromJson(output);
    return response;
  }

  Future<ChatDetailsResponse> getChatDetails({int id}) async {
    var request = await get(
      Uri.parse("${Constants.domain}chatDetails/$id"),
      headers: Constants().headers,
    );
    var output = json.decode(request.body);
    ChatDetailsResponse response = ChatDetailsResponse.fromJson(output);
    return response;
  }

  Future<ApiResponse> checkChat({int id}) async {
    var request = await get(
      Uri.parse("${Constants.domain}checkChat/$id"),
      headers: Constants().headers,
    );
    var output = json.decode(request.body);
    ApiResponse response = ApiResponse.fromJson(output);
    return response;
  }

  Future<ApiResponse> deleteChat({int id}) async {
    var request = await get(
      Uri.parse("${Constants.domain}deleteChat/$id"),
      headers: Constants().headers,
    );
    var output = json.decode(request.body);
    ApiResponse response = ApiResponse.fromJson(output);
    return response;
  }

  Future<ApiResponse> deleteMessage({int id}) async {
    var request = await get(
      Uri.parse("${Constants.domain}deleteMessage/$id"),
      headers: Constants().headers,
    );
    var output = json.decode(request.body);
    ApiResponse response = ApiResponse.fromJson(output);
    return response;
  }

  Future<ApiResponse> sendTextMessage({int id, int user, String text}) async {
    var request = await post(
      Uri.parse("${Constants.domain}sendMessage"),
      body: {
        'chat_id': '$id',
        'user_id': '$user',
        'type': '1',
        'text': '$text',
      },
      headers: Constants().headers,
    );
    var output = json.decode(request.body);
    ApiResponse response = ApiResponse.fromJson(output);
    return response;
  }

  Future<ApiResponse> sendAttachmentMessage(
      {int id, int user, int type, String text, File attachment}) async {
    var request = MultipartRequest(
      "POST",
      Uri.parse(
        "${Constants.domain}sendMessage",
      ),
    );
    Map<String, String> body = {
      'chat_id': '$id',
      'user_id': '$user',
      'type': '$type',
      'text': '$text',
    };

    request.headers.addAll(Constants().headers);
    request.fields.addAll(body);
    if (attachment != null) {
      String fileName = attachment.path.split("/").last;
      var stream = new ByteStream(DelegatingStream(attachment.openRead()));
      var length = await attachment.length();
      var multipartFile =
          new MultipartFile('attachment', stream, length, filename: fileName);

      request.files.add(multipartFile);
    }
    Response rsx = await Response.fromStream(await request.send());
    var output = json.decode(rsx.body);
    print(output);
    ApiResponse response = ApiResponse.fromJson(output);
    return response;
  }
}
