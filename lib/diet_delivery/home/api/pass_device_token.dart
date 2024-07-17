import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PassDeviceTokenToBackEnd {
  final storage = FlutterSecureStorage();
  final url = ApiConfig.baseUrl + ApiConfig.device_token;
  final signUpController = Get.find<SignUpController>();

  Future sendDeviceToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final mobile = await prefs.getString("mobile");
      log(mobile.toString(), name: "mobile number");
      await storage.write(key: "device_token", value: token);
      print('Device token: $token');
      final accessToken = await storage.read(key: "access_token");
      final response = await http.post(Uri.parse(url),
          headers: {"Authorization": "Bearer $accessToken"},
          body: json.encode({"mobile": mobile, "device_token": token}));

      log(response.body, name: "device token");
      if (response.statusCode == 200) {
        log(response.body, name: "device token");
      }
    } catch (e) {
      log("Error while sending device token $e");
    }
  }
}
