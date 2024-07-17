// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';

// class NotificationService {
//   Future<void> requestPermission() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;

//     if (Platform.isIOS) {
//       NotificationSettings settings =
//           await FirebaseMessaging.instance.requestPermission(
//         alert: true,
//         announcement: true,
//         badge: true,
//         carPlay: false,
//       );
//       if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//         print('User granted permission');
//       } else if (settings.authorizationStatus ==
//           AuthorizationStatus.provisional) {
//         print('User granted provisional permission');
//       } else {
//         print('User declined or has not authorized permission');
//       }
//     }
//   }
// }
