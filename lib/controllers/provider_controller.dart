import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/models/responses/api_response.dart';
import 'package:fixed_bids/models/responses/login_response.dart';
import 'package:fixed_bids/models/responses/nearby_jobs_response.dart';
import 'package:http/http.dart';

class ProviderController {
  Future<LoginResponse> editProfile({
    String email,
    String name,
    String latitude,
    String longitude,
    String address,
    String oldPassword,
    String password,
    String confirmPassword,
    File image
  }) async {
    var request = MultipartRequest(
      "POST",
      Uri.parse(
        "${Constants.domain}editProfile",
      ),
    );

    Map<String, String> body = {
      'name': name,
      'email': email,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'old_password': oldPassword ?? '',
      'password': password ?? '',
      'confirm_password': confirmPassword ?? '',
    };
    request.headers.addAll(Constants().headers);
    request.fields.addAll(body);
    if (image != null) {
      String fileName = image.path.split("/").last;
      var stream = new ByteStream(DelegatingStream(image.openRead()));
      var length = await image.length();
      var multipartFile =
      new MultipartFile('image_profile', stream, length, filename: fileName);

      request.files.add(multipartFile);
    }

    Response response = await Response.fromStream(await request.send());
    var output = json.decode(response.body);
    print(output);
    LoginResponse userResponse = LoginResponse.fromJson(output);
    if (userResponse.status && userResponse.code == 200) {
      Data.sharedPreferencesController.setUserData(userResponse.user);
      Data.currentUser = userResponse.user;
    } else {
      BotToast.showText(text: userResponse.message);
    }
    return userResponse;
  }

  Future<ApiResponse> editServices({
    List<int> services,
  }) async {
    Map body = {};
    for (int i = 0; i < services.length; i++) {
      body.addAll({'services[$i]': '${services[i]}'});
    }
    var request = await post(
      Uri.parse("${Constants.domain}updateMyServices"),
      body: body,
      headers: Constants().headers,
    );
    var output = json.decode(request.body);
    print(output);
    ApiResponse response = ApiResponse.fromJson(output);
    return response;
  }

  Future<NearByJobsResponse> nearbyJobs(
      {double lat, double lng, String search = ''}) async {
    var request = await get(
      Uri.parse(
          "${Constants.domain}getNearbyJobs?latitude=${lat ?? ''}&longitude=${lng ?? ''}&text=$search"),
      headers: Constants().headers,
    );
    var output = json.decode(request.body);
    print(output);
    NearByJobsResponse response = NearByJobsResponse.fromJson(output);
    return response;
  }
  Future<NearByJobsResponse> getAcceptedJobsByProvider({int isOpen = 1}) async {
    var request = await get(
      Uri.parse("${Constants.domain}getAcceptdJobsByProvider?is_open=$isOpen"),
      headers: Constants().headers,
    );
    var output = json.decode(request.body);
    print(output);
    NearByJobsResponse response = NearByJobsResponse.fromJson(output);
    return response;
  }

}
