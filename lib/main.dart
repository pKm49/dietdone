import 'package:diet_diet_done/splash_screen/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'core/localization/localization.dart';
import 'core/theme/theme_constant.dart';
import 'helper/init_dependency.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
