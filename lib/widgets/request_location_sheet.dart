import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestLocationSheet extends StatefulWidget {
  @override
  _RequestLocationSheetState createState() => _RequestLocationSheetState();
}

class _RequestLocationSheetState extends State<RequestLocationSheet> {
  bool isFirstTime = true;
  bool isClosed = false;
  Stream<bool> locationEventStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationEventStream = Permission.location.request()
        .asStream()
        .map((s) => s.isGranted  ? true : false);
    locationEventStream.listen((status) {
      if (isClosed) return;
      if (isFirstTime) {
        isFirstTime = false;
        return;
      }
      if (status) Navigator.of(context).pop(status);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isClosed = true;
    locationEventStream = null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Container(
          child: Text(
            'PleaseMakeSureTheGpsIsEnabled',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 50,
        ),
        TextButton(
          onPressed:  () async {
            if (Platform.isAndroid) {
              final AndroidIntent intent = AndroidIntent(
                  action: 'android.settings.LOCATION_SOURCE_SETTINGS');
              await intent.launch();
            }
          },
          child: Text('GoToSettings'),
        ),
      ],
    );
  }
}
