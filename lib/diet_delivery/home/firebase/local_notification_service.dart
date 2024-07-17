import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as flutter_local_notifications;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  Future<void> initNotification() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      debugPrint("onDidReceiveNotificationResponse triggered");
      debugPrint("payload is " + notificationResponse.payload.toString());

      final List<String> str = notificationResponse.payload!
          .replaceAll('{', '')
          .replaceAll('}', '')
          .split(',');
      final Map<String, dynamic> result = <String, dynamic>{};
      for (int i = 0; i < str.length; i++) {
        final List<String> s = str[i].split(':');
        result.putIfAbsent(s[0].trim(), () => s[1].trim());
      }

      onActionReceivedImplementationMethod(result);
    });

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  Future<void> onActionReceivedImplementationMethod(
      Map<String, dynamic> data) async {
    debugPrint("onActionReceivedImplementationMethod triggered");
    debugPrint(data.toString());
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future handleFcmNotification(RemoteMessage? message) async {
    debugPrint("FirebaseMessaging onMessage triggered");
    debugPrint("payload is " + message!.data.toString());

    final RemoteNotification? notification = message.notification;
    final Map<String, dynamic> data = message.data;
    final AndroidNotification? android = message.notification?.android;
    final AppleNotification? apple = message.notification?.apple;
    String logoPath =
        "https://lh3.googleusercontent.com/4h2XkERxolE4FL97S1AwPucH48MwqbrLc63B5PvunkPoVHd_X1bKPfILsmzy-ZHTEuQ";
    String imageUrl = logoPath;

    if (android != null) {
      if (android.imageUrl != null) {
        imageUrl = android.imageUrl ?? logoPath;
      }
    }
    if (apple != null) {
      if (apple.imageUrl != null) {
        imageUrl = apple.imageUrl ?? logoPath;
      }
    }

    String bigPicturePath = "";
    try {
      bigPicturePath = await _downloadAndSaveFile(imageUrl, 'bigPicture');
    } catch (e) {
      bigPicturePath = await _downloadAndSaveFile(logoPath ?? "", 'bigPicture');
    }

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath));
    // If `onMessage` is triggered with a notification, construct our own
// local notification to show to users using the created channel.

    if (notification != null) {
      notificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        flutter_local_notifications.NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description,
              icon: '@mipmap/ic_launcher',
              styleInformation: bigPictureStyleInformation),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: message.data.toString(),
      );
    }
  }
}
