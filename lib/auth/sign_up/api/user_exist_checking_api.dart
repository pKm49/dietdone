import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class UserExistCheckingAPiService {
  final storage = FlutterSecureStorage();
  final signUpController = Get.find<SignUpController>();

  Future<String> userExistChecking() async {
    try {
      Get.dialog(
          Center(
              child: CircularProgressIndicator(
            color: kPrimaryColor,
          )),
          barrierDismissible: false);
      final accessToken = await storage.read(key: "access_token");
      final url =
          "${ApiConfig.baseUrl}${ApiConfig.userExist}${signUpController.phoneNumberController.text}";
      log(url);
      final response = await http.get(Uri.parse(url),
          headers: {"Authorization": "Bearer $accessToken"});
      if (response.statusCode == 200) {
        log(response.body, name: "user checking");
        final message = jsonDecode(response.body)["error"];
        log(message, name: "User checking message");
        Get.back();
        return message;
      } else {
        Get.back();

        throw Exception("Error while checking user exist");
      }
    } catch (e) {
      Get.back();

      throw Exception("Error while checking user exist $e");
    } finally {}
  }
}
