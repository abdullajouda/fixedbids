import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixed_bids/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:rxdart/rxdart.dart';

import 'local_notifications_service.dart';

class LocalNotification {
  final String type;
  final Map data;

  LocalNotification(this.type, this.data);
}

class NotificationsBloc {
  NotificationsBloc._internal();

  static final NotificationsBloc instance = NotificationsBloc._internal();

  final BehaviorSubject<LocalNotification> _notificationsStreamController =
  BehaviorSubject<LocalNotification>();

  Stream<LocalNotification> get notificationsStream {
    return _notificationsStreamController;
  }

  void newNotification(LocalNotification notification) {
    _notificationsStreamController.sink.add(notification);
  }

  void dispose() {
    _notificationsStreamController?.close();
  }
}

class FirebaseMessagingService {
  static FirebaseMessagingService _instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  static FirebaseMessagingService get instance {
    if (_instance != null) return _instance;
    return _instance = FirebaseMessagingService();
  }

  Future<void> _messageHandler(RemoteMessage message) async {
    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification?.android;
    if (notification != null && android != null) {
      localNotificationsService.showNotification(
        notification.title,
        notification.body,
      );
    }
  }

  Future getToken()async{
    String token = await _fcm.getToken();
    print("FirebaseMessaging token: $token");
    Data.fcm = token;
  }

  Future initialise() async {
    if (Platform.isIOS) {
      _fcm.setForegroundNotificationPresentationOptions(
          sound: true, badge: true, alert: true);
    }


    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {}
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        BotToast.showNotification(
          onTap: () {

          },
          title: (cancelFunc) =>
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 274,
                    child: Text(
                      notification.title,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    notification.body,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xff8a8a8f),
                    ),
                  )
                ],
              ),
        );
        // localNotificationsService.showNotification(
        //   notification.title,
        //   notification.body,
        // );
      }
    });

    FirebaseMessaging.onBackgroundMessage(_messageHandler);

    FirebaseMessaging.onMessageOpenedApp.listen(
          (RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');

      },
    );
  }
}
