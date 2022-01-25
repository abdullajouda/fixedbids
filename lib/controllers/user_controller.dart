import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:fixed_bids/constants.dart';
import 'package:fixed_bids/models/responses/login_response.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart';

class UserController {
  Future<LoginResponse> editProfile({
    String email,
    String name,
    String latitude,
    String longitude,
    String address,
    String oldPassword,
    String password,
    String confirmPassword,
  }) async {
    var response = await post(
      Uri.parse("${Constants.domain}editProfile"),
      body: {
        'name': name,
        'email': email,
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        'old_password': oldPassword ?? '',
        'password': password ?? '',
        'confirm_password': confirmPassword ?? '',
      },
      headers: Constants().headers,
    );
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
}
