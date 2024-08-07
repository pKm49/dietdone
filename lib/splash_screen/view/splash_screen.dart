import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:diet_diet_done/auth/login/api/get_access_token_service.dart';
import 'package:diet_diet_done/auth/login/view/login_screen.dart';
import 'package:diet_diet_done/auth/login/view/welcome_screen.dart';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/diet_delivery/home/model/get_profile_model.dart';
import 'package:diet_diet_done/diet_delivery/home/view/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
    print("redirectToNextScreen");
    print(hasSeenWelcomeScreen);
    if (hasSeenWelcomeScreen == null || hasSeenWelcomeScreen == false) {
      Get.off(() => const WelcomeScreen());
    } else {
      final mobile = await prefs.getString("mobile");
      log(mobile.toString(), name: "mobiiiiiiiiiiile");
      if (mobile == null || mobile.isEmpty) {
        Get.off(() => LoginScreen());
      } else {

        try{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final mobile = await prefs.getString("mobile");
          // SharedPreferences preferences = await SharedPreferences.getInstance();
          // signUpController.mobileNumber = preferences.getString("mobileNumber");
          final url = "${ApiConfig.baseUrl}${ApiConfig.profile}?mobile=$mobile";
          log(url.toString(), name: "get profile url");
          final storage = FlutterSecureStorage();

          final accessToken = await storage.read(key: "access_token");
          final response = await http.get(
            Uri.parse(url),
            headers: {"Authorization": "Bearer $accessToken"},
          );
          print("redirectToNextScreen response");
          print(response.statusCode);
          print(response.body);
          if (response.statusCode == 200) {
            if (jsonDecode(response.body)["statusCode"] == 200) {
              Get.off(() => BottomNavBar());
            } else {
              Get.offAll(LoginScreen());
            }
          } else {
            Get.offAll(LoginScreen());
          }

        }catch (e){
          Get.offAll(LoginScreen());

        }
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
