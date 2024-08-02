import 'dart:async';
import 'dart:developer';
import 'package:diet_diet_done/auth/login/api/get_access_token_service.dart';
import 'package:diet_diet_done/auth/login/view/login_screen.dart';
import 'package:diet_diet_done/auth/login/view/welcome_screen.dart';
import 'package:diet_diet_done/diet_delivery/home/view/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () async {
      // await callAccessTokenEvery24hr();
      await GetAccessTokenService().getAccessToken();
      redirectToNextScreen();
    });

    super.initState();
  }

  Future callAccessTokenEvery24hr() async {
    await GetAccessTokenService().getAccessToken();
    final duration = Duration(hours: 24);
    Timer(duration, callAccessTokenEvery24hr);
  }

  Future<void> redirectToNextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final hasSeenWelcomeScreen = await prefs.getBool("hasSeenWelcomeScreen");

    if (hasSeenWelcomeScreen == null || hasSeenWelcomeScreen == false) {
      Get.off(() => const WelcomeScreen());
    } else {
      final mobile = await prefs.getString("mobile");
      log(mobile.toString(), name: "mobiiiiiiiiiiile");
      if (mobile == null || mobile.isEmpty) {
        Get.off(() => LoginScreen());
      } else {
        Get.off(() => BottomNavBar());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image(image: AssetImage("assets/gif/diet_done.gif"))),
    );
  }
}
