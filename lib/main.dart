import 'package:diet_diet_done/diet_delivery/home/firebase/local_notification_service.dart';
import 'package:diet_diet_done/diet_delivery/home/firebase/notification_controller.dart';
import 'package:diet_diet_done/firebase_options.dart';
import 'package:diet_diet_done/splash_screen/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'core/localization/localization.dart';
import 'core/theme/theme_constant.dart';
import 'helper/init_dependency.dart';


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService().initNotification();
  NotificationService().handleFcmNotification(message);
  print("Handling a background message: ${message.messageId}");
}

void main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  NotificationService().initNotification();

  NotificationController notificationController = NotificationController();
  notificationController.setupInteractedMessage();
  // await NotificationService.initializeNotification();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: InitDependency(),
          locale: const Locale("en", "US"),
          fallbackLocale: const Locale("en", "US"),
          translations: Localization(),
          theme: themeData,
          home: SplashScreen()),
    );
  }
}
