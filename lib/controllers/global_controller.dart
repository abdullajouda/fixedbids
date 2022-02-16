import 'dart:convert';
import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/models/responses/ads_response.dart';
import 'package:fixed_bids/models/responses/api_response.dart';
import 'package:fixed_bids/models/responses/banners_response.dart';

import 'package:fixed_bids/models/responses/login_response.dart';
import 'package:fixed_bids/models/responses/notifications_response.dart';
import 'package:fixed_bids/models/responses/profile_response.dart';
import 'package:fixed_bids/models/responses/questions_response.dart';
import 'package:fixed_bids/models/responses/services_response.dart';
import 'package:fixed_bids/models/responses/settings_response.dart';
import 'package:async/async.dart';
import 'package:fixed_bids/models/responses/user_by_service_response.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'notifications_controller.dart';

class GlobalController {
  Future getSettings() async {
    var request = await get(
      Uri.parse("${Constants.domain}getSetting"),
      headers: Constants().headers,
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
    BannersResponse response =
        BannersResponse.fromJson(json.decode(request.body));
    if (response.notifiyCount > 0) {
      Data.navigator.navigator.context
          .read<NotificationsController>()
          .notificationCount = response.notifiyCount;
    }
    return response;
  }

  Future<QuestionsResponse> allQuestions() async {
    var request = await get(
      Uri.parse("${Constants.domain}allQuestions"),
      headers: Constants().headers,
    );
    return QuestionsResponse.fromJson(json.decode(request.body));
  }

  Future<NotificationsResponse> myNotifications() async {
    var request = await get(
      Uri.parse("${Constants.domain}myNotifications"),
      headers: Constants().headers,
    );
    return NotificationsResponse.fromJson(json.decode(request.body));
  }

  Future<ServicesResponse> getServices() async {
    var request = await get(
      Uri.parse("${Constants.domain}getServices"),
      headers: Constants().headers,
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

  Future<LoginResponse> register({
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
        'latitude': latitude ?? '',
        'longitude': longitude ?? '',
      },
      headers: Constants().headers,
    );
    var output = json.decode(response.body);
    print(output);
    LoginResponse userResponse = LoginResponse.fromJson(output);
    return userResponse;
  }

  Future<ApiResponse> contactUs(
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
    return ApiResponse.fromJson(json.decode(response.body));
  }

  Future<ApiResponse> newReview({
    String rate,
    String offerId,
    String comment,
  }) async {
    var response = await post(
      Uri.parse("${Constants.domain}newReview"),
      body: {
        'rate': rate,
        'offerId': offerId,
        'comment': comment,
      },
      headers: Constants().headers,
    );
    return ApiResponse.fromJson(json.decode(response.body));
  }

  Future<ApiResponse> forgotPassword({String email}) async {
    var response = await post(
      Uri.parse("${Constants.domain}forgotPassword"),
      body: {
        'email': email,
      },
      headers: Constants().headers,
    );
    return ApiResponse.fromJson(json.decode(response.body));
  }

  Future<ProfileResponse> getProfileById({int id}) async {
    var request = await get(
      Uri.parse("${Constants.domain}getProfileById/$id"),
      headers: Constants().headers,
    );
    ProfileResponse response =
        ProfileResponse.fromJson(json.decode(request.body));
    if (response.status) {
      Data.currentUser.completeJobCount = response.item.completeJobCount;
      Data.currentUser.rate = response.item.rate;
      Data.currentUser.servises = response.item.servises;
    }
    return response;
  }

  Future<UsersByServiceResponse> getUsersByServiceId({int id}) async {
    var request = await get(
      Uri.parse("${Constants.domain}getUsersByServiceId/$id"),
      headers: Constants().headers,
    );
    return UsersByServiceResponse.fromJson(json.decode(request.body));
  }

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
