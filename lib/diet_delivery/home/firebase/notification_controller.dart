import 'package:diet_diet_done/diet_delivery/home/firebase/local_notification_service.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationController {
  Future<void> setupInteractedMessage() async {
    // This function is called when ios app is opened, for android case `onDidReceiveNotificationResponse` function is called
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      NotificationService().handleFcmNotification(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        debugPrint("onMessageOpenedApp triggered");
        debugPrint(message.toString());
        NotificationService()
            .onActionReceivedImplementationMethod(message.data);
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      NotificationService().handleFcmNotification(message);
    });
  }
}
