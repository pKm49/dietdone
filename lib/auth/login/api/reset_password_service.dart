import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/auth/login/view/pass_success_screen.dart';
import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_support/overlay_support.dart';

class ResetPasswordApiService {
  final storage = const FlutterSecureStorage();
  final signUpController = Get.find<SignUpController>();

  Future resetPassword() async {
    final accessToken = await storage.read(key: "access_token");
    String url = "${ApiConfig.baseUrl}${ApiConfig.resetPassword}";

    Get.dialog(Center(child: CircularProgressIndicator()));
    final response = await http.patch(Uri.parse(url),
        headers: {"Authorization": "Bearer $accessToken"},
        body: json.encode({
          "mobile": signUpController.phoneNumberController.text,
          "new_password": signUpController.newPasswordController.text
        }));
    log(response.body.toString(), name: "Reset Password");
    final statusCode = jsonDecode(response.body)["statusCode"];
    final message = jsonDecode(response.body)["message"];
    final errorMessage = jsonDecode(response.body)["error"];
    log(message, name: "reset password");
    toast(message);
    if (statusCode == 200) {
      Get.back();
      Get.to(PassChangedSuccessScreen());
    } else {
      toast(errorMessage);
      log("Failed to reset password. status code: ${response.statusCode}${response.body}");
    }
  }
}
