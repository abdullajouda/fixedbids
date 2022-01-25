import 'dart:convert';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:fixed_bids/constants.dart';
import 'package:fixed_bids/models/responses/ads_response.dart';
import 'package:fixed_bids/models/responses/api_response.dart';
import 'package:fixed_bids/models/responses/banners_response.dart';
import 'package:fixed_bids/models/responses/login_response.dart';
import 'package:fixed_bids/models/responses/questions_response.dart';
import 'package:fixed_bids/models/responses/services_response.dart';
import 'package:fixed_bids/models/responses/settings_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class GlobalController {
  Future getSettings() async {
    var request = await get(
      Uri.parse("${Constants.domain}getSetting"),
      headers: {
        'Accept-Language': Data.locale.languageCode,
        'Accept': 'application/json',
      },
    );
    var output = json.decode(request.body);
    SettingsResponse response = SettingsResponse.fromJson(output);
    Data.settings = response;
   await getServices();
  }

  Future<AdsResponse> getAds() async {
    var request = await get(
      Uri.parse("${Constants.domain}getAds"),
      headers: Constants().headers,
    );
    return AdsResponse.fromJson(json.decode(request.body));
  }

  Future<BannersResponse> getBanners() async {
    var request = await get(
      Uri.parse("${Constants.domain}getBanners"),
      headers: Constants().headers,
    );
    return BannersResponse.fromJson(json.decode(request.body));
  }

  Future<QuestionsResponse> allQuestions() async {
    var request = await get(
      Uri.parse("${Constants.domain}allQuestions"),
      headers: {
        'Accept-Language': Data.locale.languageCode,
        'Accept': 'application/json',
      },
    );
    return QuestionsResponse.fromJson(json.decode(request.body));
  }

  Future<ServicesResponse> getServices() async {
    var request = await get(
      Uri.parse("${Constants.domain}getServices"),
      headers: {
        'Accept-Language': Data.locale.languageCode,
        'Accept': 'application/json',
      },
    );
    var output = json.decode(request.body);
    ServicesResponse response = ServicesResponse.fromJson(output);
    Data.services = response;
    return response;
  }

  Future<LoginResponse> signIn({String email, String password}) async {
    var response = await post(
      Uri.parse("${Constants.domain}login"),
      body: {
        'email': email,
        'password': password,
        // 'type_mobile': Platform.isAndroid ? '0' : '1',
        // 'fcmToken': Data.fcm ?? '12dw31',
      },
      headers: Constants().headers,
    );
    var output = json.decode(response.body);
    print(output);
    LoginResponse userResponse = LoginResponse.fromJson(output);
    return userResponse;
  }

  Future<ApiResponse> register({
    String email,
    String password,
    String confirmPassword,
    String name,
    String latitude,
    String longitude,
    int type,
  }) async {
    var response = await post(
      Uri.parse("${Constants.domain}signUp"),
      body: {
        'email': email,
        'name': name,
        'password': password,
        'confirm_password': confirmPassword,
        'type': type.toString(),
        'latitude': latitude,
        'longitude': longitude,
      },
      headers: Constants().headers,
    );
    var output = json.decode(response.body);
    print(output);
    ApiResponse userResponse = ApiResponse.fromJson(output);
    return userResponse;
  }

  Future contactUs(
      {String email, String name, String mobile, String message}) async {
    var response = await post(
      Uri.parse("${Constants.domain}contactUs"),
      body: {
        'name': name,
        'email': email,
        'mobile': mobile,
        'message': message,
      },
      headers: Constants().headers,
    );
    var output = json.decode(response.body);
    if (output['status'] == true) {
    } else {}
  }

  Future forgotPassword({String email}) async {
    var response = await post(
      Uri.parse("${Constants.domain}forgotPassword"),
      body: {
        'email': email,
      },
      headers: Constants().headers,
    );
    var output = json.decode(response.body);
  }

// Future<List<FavoriteModel>> getFavorites() async {
//   var request = await get(
//     Uri.parse("${Constants.domain}getMyFavorite"),
//     headers: Constants().headers,
//   );
//   var output = json.decode(request.body);
//   List<FavoriteModel> list = (output['items'] as List)
//       .map((e) => FavoriteModel.fromJson(e))
//       .toList();
//   return list;
// }

// Future<ApiResponse> addRemoveFavorite({int id}) async {
//   var request = await get(
//     Uri.parse("${Constants.domain}addAndRemoveFromFavorite/$id"),
//     headers: Constants().headers,
//   );
//   var output = json.decode(request.body);
//   ApiResponse response = ApiResponse.fromJson(output);
//   return response;
// }

  logout() async {
    await get(
      Uri.parse("${Constants.domain}logout"),
      headers: Constants().headers,
    );
  }

// changeLanguage({String lang}) async {
//   await post(
//     Uri.parse("${Constants.domain}changeLanguge"),
//     body: {
//       'fcmToken': Data.fcm,
//       'lang': lang,
//       'type_mobile': '${Platform.isIOS ? 1 : 0}',
//     },
//     headers: Constants().headers,
//   );
// }

// receiveNotification({int status}) async {
//   await post(
//     Uri.parse("${Constants.domain}receiveNotification"),
//     body: {
//       'status': status,
//     },
//     headers: Constants().headers,
//   );
// }
}
