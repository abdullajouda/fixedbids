import 'dart:convert';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
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
import 'package:fixed_bids/views/root.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:fixed_bids/models/responses/user_by_service_response.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
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

  Future<LoginResponse> socialLogin({String token, String type}) async {
    var response = await post(
      Uri.parse("${Constants.domain}socialSignUp"),
      body: {
        'social_token': token,
        'social_type': type,
        'device_type': Platform.isAndroid ? 'android' : 'ios',
        'fcm_token': Data.fcm,
      },
      headers: Constants().headers,
    );
    var output = json.decode(response.body);
    print(output);
    LoginResponse userResponse = LoginResponse.fromJson(output);
    return userResponse;
  }

  Future<LoginResponse> socialCreateNewAccount(
      {String token, String socialType, int type}) async {
    var response = await post(
      Uri.parse("${Constants.domain}socialCreateNewAccount"),
      body: {
        'social_token': token,
        'social_type': socialType,
        'device_type': Platform.isAndroid ? 'android' : 'ios',
        'fcm_token': Data.fcm,
        'type': '$type',
      },
      headers: Constants().headers,
    );
    var output = json.decode(response.body);
    print(output);
    LoginResponse userResponse = LoginResponse.fromJson(output);
    return userResponse;
  }

  Future<LoginResponse> facebookLogin() async {
    final fb = FacebookLogin();

// Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (res.status) {
      case FacebookLoginStatus.success:
        // Logged in

        // Send access token to server for validation and auth
        final FacebookAccessToken accessToken = res.accessToken;
        print('Access token: ${accessToken.token}');

        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile.name}! You ID: ${profile.userId}');

        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) print('And your email is $email');
        LoginResponse response =
        await socialLogin(type: 'google', token: accessToken.token);
        return response;
        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        BotToast.showText(text: res.error.localizedTitle);
        return null;
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        BotToast.showText(text: res.error.localizedTitle);
        print('Error while log in: ${res.error}');
        return null;
        break;
      default:
        return null;
        break;
    }
  }

  Future <LoginResponse>  signInGmail() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    if (await _googleSignIn.isSignedIn()) await _googleSignIn.signOut();
    var account = await _googleSignIn.signIn();
    var token = await account.authentication;
    LoginResponse firstResponse =
        await socialLogin(type: 'google', token: token.accessToken);
   return firstResponse;
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

  Future<UsersByServiceResponse> getUsersByServiceId(
      {int id, String text}) async {
    var request = await get(
      Uri.parse(
          "${Constants.domain}getUsersByServiceId/$id?text=${text ?? ''}"),
      headers: Constants().headers,
    );
    return UsersByServiceResponse.fromJson(json.decode(request.body));
  }

  logout() async {
    await get(
      Uri.parse("${Constants.domain}logout"),
      headers: Constants().headers,
    );
    Data.sharedPreferencesController.clearUserData();
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
