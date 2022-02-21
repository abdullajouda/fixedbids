import 'dart:io';

import 'package:fixed_bids/models/user.dart';
import 'package:fixed_bids/widgets/request_location_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controllers/shared_preferences_controller.dart';
import '../models/option.dart';
import '../models/responses/services_response.dart';
import '../models/responses/settings_response.dart';
import 'dart:ui' as ui;

// const redColor = Color.fromRGBO(251, 133, 119, 1);
// const darkRedColor = Color.fromRGBO(252, 80, 80, 1);
const purpleColor = Color.fromRGBO(227, 214, 255, 1);
// const darkPurpleColor = Color.fromRGBO(162, 118, 255, 1);
// const lightOrangeColor = Color.fromRGBO(254, 218, 214, 1);
const yellowColor = Color.fromRGBO(255, 245, 194, 1);
const shadowColor = Color.fromRGBO(0, 0, 0, 0.05);
const kPrimaryColor = Color(0x0ff1F71ED);
const kTextColor = Color(0x0ff252225);
const kAppbarTitleColor = Color(0x0ff2E2E2E);
const kTextMidColor = Color(0x0ff626262);
const kTextLightColor = Color(0x0ff999999);
const kBackGroundColor = Color(0x0ffF8F8F8);
const grayColor = Color(0x0ffC4C4C4);
const kPadding = EdgeInsets.symmetric(horizontal: 36);
const emailRegExp =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

class Data {
  static Size size;
  static LatLng currentLocation;
  static SharedPreferencesController sharedPreferencesController;
  static NavigatorObserver navigator = NavigatorObserver();

  static User currentUser;
  static final ImagePicker picker = ImagePicker();

  static String fcm;
  static Locale locale;
  static SettingsResponse settings;
  static ServicesResponse services;
}

class Constants {
  static const String domain = 'https://fixedbids.com/api/';

  static const String User_type_Guest = '-1';
  static const String User_type_User = '0';
  static const String User_type_Contractor = '1';

  Map<String, String> headers = {
    'Accept': 'application/json',
    'fcm_token': '${Data.fcm}',
    'Accept-Language': '${Data.locale.languageCode}',
    'Authorization': Data.currentUser != null
        ? 'Bearer ${Data.currentUser.accessToken}'
        : '',
  };

  List<Option> urgencyOptions = [
    Option(id: 1, title: 'LOW'),
    Option(id: 2, title: 'HIGH'),
    Option(id: 3, title: 'EMERGENCY'),
  ];

  static TextStyle applyStyle(
      {double size, Color color, FontWeight fontWeight}) {
    return TextStyle(
      color: color != null ? color : kTextColor,
      fontSize: size ?? 24,
      fontWeight: fontWeight ?? FontWeight.w400,
    );
  }

  static Future<LatLng> getCurrentLocation({
    @required BuildContext context,
    bool isNewestLocation = false,
  }) async {
    if (!isNewestLocation && Data.currentLocation != null)
      return Data.currentLocation;
    // Location location = Location.instance;
    PermissionStatus permissionStatus = await Permission.location.request();
    if (permissionStatus == PermissionStatus.granted) {
      if (Platform.isIOS) {
        showDialog(
          context: context,
          builder: (context) => Material(
            color: Colors.transparent,
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          ),
        );
        Position locationData = await Geolocator.getCurrentPosition();
        Navigator.pop(context);
        return Data.currentLocation = LatLng(
          locationData.latitude,
          locationData.longitude,
        );
      }
      bool isGps = await Geolocator.isLocationServiceEnabled();
      if (isGps) {
        showDialog(
          context: context,
          builder: (context) => Material(
            color: Colors.transparent,
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          ),
        );
        Position locationData = await Geolocator.getCurrentPosition();
        Navigator.pop(context);
        return Data.currentLocation = LatLng(
          locationData.latitude,
          locationData.longitude,
        );
      } else {
        bool isGpsEnabled = await Constants.bottomSheet(
          context: context,
          child: RequestLocationSheet(),
        );
        if (isGpsEnabled == null) return null;
        showDialog(
          context: context,
          builder: (BuildContext context) => Material(
            color: Colors.transparent,
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          ),
        );
        Position locationData = await Geolocator.getCurrentPosition();
        Navigator.pop(context);
        return Data.currentLocation = LatLng(
          locationData.latitude,
          locationData.longitude,
        );
      }
    } else
      return null;
  }

  static Future<dynamic> bottomSheet({
    @required BuildContext context,
    @required Widget child,
    Color backgroundColor,
    bool enableDrag = true,
    double radius = 30,
    bool isScrollControlled = true,
  }) async {
    return await showModalBottomSheet(
      context: context,
      enableDrag: enableDrag,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radius),
        ),
      ),
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      builder: (_) => child,
    );
  }
}


  class FieldValidator {
    static String validate(String value, context) {
      if (value.isEmpty) {
        return '* Required'.tr();
      }
      return null;
    }
  }

  class EmailValidator {
    static String validate(String value, context) {
      if (value.isEmpty) {
        return '* Required'.tr();
      }
      RegExp regExp = new RegExp(emailRegExp);
      if (!regExp.hasMatch(value)) {
        return 'Enter A Valid Email'.tr();
      }
      return null;
    }
  }

InputDecoration inputDecoration(
    {Widget suffix,
    Widget suffixIcon,
    Widget prefix,
    Widget prefixIcon,
    BorderRadius radius,
    String hint,
    bool focused = false}) {
  return InputDecoration(
    fillColor: Color(0x0ffF2F2F2),
    filled: !focused,
    alignLabelWithHint: true,
    labelStyle: Constants.applyStyle(size: 18, color: grayColor),
    floatingLabelStyle: Constants.applyStyle(size: 18, color: kPrimaryColor),
    labelText: hint,
    prefix: prefix,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon ??
        (suffix != null
            ? Container(width: 17, child: Center(child: suffix))
            : null),
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    border: OutlineInputBorder(
      borderRadius: radius ?? BorderRadius.circular(12.0),
      borderSide: BorderSide(
        width: 0.0,
        color: Color(0x0ffF2F2F2),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: radius ?? BorderRadius.circular(12.0),
      borderSide: BorderSide(
        width: focused ? 1 : 0,
        color: focused ? kPrimaryColor : Color(0x0ffF2F2F2),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius ?? BorderRadius.circular(12.0),
      borderSide: BorderSide(width: 1.0, color: kPrimaryColor),
    ),
  );
}

InputDecoration fatInputDecoration(
    {Widget suffix, Widget prefix, String hint, bool focused = false}) {
  return InputDecoration(
    fillColor: Color(0x0ffF2F2F2),
    filled: !focused,
    labelStyle: Constants.applyStyle(size: 18, color: grayColor),
    alignLabelWithHint: true,
    floatingLabelStyle: Constants.applyStyle(size: 18, color: kPrimaryColor),
    labelText: hint,
    prefix: prefix,
    suffixIcon: suffix != null
        ? Container(width: 17, child: Center(child: suffix))
        : null,
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(
        width: 0.0,
        color: Color(0x0ffF2F2F2),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(
        width: focused ? 1 : 0,
        color: focused ? kPrimaryColor : Color(0x0ffF2F2F2),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(width: 1.0, color: kPrimaryColor),
    ),
  );
}

InputDecoration searchInputDecoration({String hint, Widget suffix}) {
  return InputDecoration(
    fillColor: Colors.white,
    filled: true,
    hintStyle: TextStyle(
      fontSize: 14,
      color: Color.fromRGBO(153, 153, 153, 1),
      letterSpacing: 0.4,
      fontWeight: FontWeight.w400,
    ),
    hintText: hint ?? '',
    suffixIcon: Container(
      width: 17,
      child: Center(child: suffix),
    ),
    prefixIcon: Container(
      width: 17,
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/Search.svg',
          color: Color.fromRGBO(153, 153, 153, 1),
        ),
      ),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 15),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(width: 0, color: Colors.transparent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(width: 0, color: Colors.transparent),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(width: 0, color: Colors.transparent),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(
        color: Colors.red,
        width: 1.0,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(
        color: Colors.red,
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(width: 0.0, color: Colors.transparent),
    ),
  );
}

// InputDecoration messagingDecoration({String hint, Widget suffix}) {
//   return InputDecoration(
//     fillColor: lightGreenColor,
//     filled: true,
//     hintStyle: TextStyle(
//       fontSize: 16,
//       color: Color.fromRGBO(0, 14, 45, 0.6),
//       letterSpacing: 0.7000000000000001,
//       fontWeight: FontWeight.w300,
//     ),
//     hintText: hint ?? '',
//     suffixIcon: Container(
//       width: 18,
//       child: Center(
//         child: suffix,
//       ),
//     ),
//     contentPadding: EdgeInsets.symmetric(horizontal: 15),
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: BorderSide(width: 0, color: lightGreenColor),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: BorderSide(width: 0, color: lightGreenColor),
//     ),
//     disabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: BorderSide(width: 0, color: lightGreenColor),
//     ),
//     errorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: BorderSide(
//         color: Colors.red,
//         width: 1.0,
//       ),
//     ),
//     focusedErrorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: BorderSide(
//         color: Colors.red,
//         width: 1.0,
//       ),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: BorderSide(width: 0.0, color: lightGreenColor),
//     ),
//   );
// }

Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset(
    BuildContext context, String assetName) async {
  String svgString = await DefaultAssetBundle.of(context).loadString(assetName);
  //Draws string representation of svg to DrawableRoot
  DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, null);
  ui.Picture picture = svgDrawableRoot.toPicture();
  ui.Image image = await picture.toImage(165, 192);
  ByteData bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
}
