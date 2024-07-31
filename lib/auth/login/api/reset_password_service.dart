import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/auth/login/view/create_new_pass_screen.dart';
import 'package:diet_diet_done/auth/login/view/otp_verification_screen.dart';
import 'package:diet_diet_done/auth/login/view/pass_success_screen.dart';
import 'package:diet_diet_done/auth/sign_up/controller/local_controller.dart';
import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_support/overlay_support.dart';

class ResetPasswordApiService {
  final storage = const FlutterSecureStorage();
  final signUpController = Get.find<SignUpController>();
  Future sendOtp() async {
    final accessToken = await storage.read(key: "access_token");
    String url = "${ApiConfig.baseUrl}${ApiConfig.sendOtp}";

    Get.dialog(Center(child: CircularProgressIndicator()));
    final response = await http.post(Uri.parse(url),
        headers: {"Authorization": "Bearer $accessToken"},
        body: json.encode({
          "mobile": signUpController.phoneNumberController.text,
          "reset_password":true
        }));
    log(response.body.toString(), name: "Reset Password");
    final statusCode = jsonDecode(response.body)["statusCode"];
    final message = jsonDecode(response.body)["message"];
    final errorMessage = jsonDecode(response.body)["error"];
    log(message, name: "reset password");
    toast(statusCode.toString());
    toast(errorMessage);
    if (statusCode == 200) {
      Get.back();
      Get.to(ForgotPasswordOtpScreen(
      ));
    } else {
      Get.back();
      Get.snackbar("Phone number is not valid",
          "Please make sure that your phone number and country code is correct",
          backgroundColor: kPrimaryColor, colorText: kWhiteColor);
      log("Failed to reset password. status code: ${response.statusCode}${response.body}");
    }
  }

  Future verifyOtp() async {
    final accessToken = await storage.read(key: "access_token");
    String url = "${ApiConfig.baseUrl}${ApiConfig.verifyOtp}?mobile=${signUpController.phoneNumberController.text}&otp=${signUpController.forgetPasswordOtpController.text}";

    Get.dialog(Center(child: CircularProgressIndicator()));
    final response = await http.get(Uri.parse(url),
        headers: {"Authorization": "Bearer $accessToken"} );
    log(response.body.toString(), name: "Reset Password");
    final statusCode = jsonDecode(response.body)["statusCode"];
    final message = jsonDecode(response.body)["message"];
    final errorMessage = jsonDecode(response.body)["error"];
    log(message, name: "reset password");
    toast(message);
    if (statusCode == 200) {
      Get.back();
      Get.to(CreateNewPassScreen());
    } else {
      toast(errorMessage);
      log("Failed to reset password. status code: ${response.statusCode}${response.body}");
    }
  }

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
