import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/auth/sign_up/view/otp_screen.dart';
import 'package:diet_diet_done/auth/sign_up/view/otp_succuss_screen.dart';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_support/overlay_support.dart';

class OTPService {
  final signUpController = Get.find<SignUpController>();
  final storage = FlutterSecureStorage();
  final url = ApiConfig.baseUrl + ApiConfig.sendOtp;
  Future sendOTP() async {
    Get.dialog(
        Center(
            child: CircularProgressIndicator(
          color: kPrimaryColor,
        )),
        barrierDismissible: false);

    final accessToken = await storage.read(key: "access_token");
    final mobile = signUpController.mobileNumber;
    try {
      final response = await http.post(Uri.parse(url),
          headers: {"Authorization": "Bearer $accessToken"},
          body: json.encode({"mobile": mobile}));
      log(response.body.toString(), name: "sending otp");
      Get.back();

      if (response.statusCode == 200) {
        log(response.body.toString(), name: "sending otp");
        Get.to(OtpScreen());
      }
    } catch (e) {
      Get.back();

      log("Error while sending otp to mobile number $e");
    }
  }

  Future verifyOTP() async {
    final otp = signUpController.otpController.text;

    final accessToken = await storage.read(key: "access_token");
    final mobile = signUpController.mobileNumber;
    final verifyOTPurl =
        "${ApiConfig.baseUrl}${ApiConfig.verifyOtp}?mobile=$mobile&otp=$otp";

    Get.dialog(
        Center(
            child: CircularProgressIndicator(
          color: kPrimaryColor,
        )),
        barrierDismissible: false);
    try {
      final response = await http.get(
        Uri.parse(verifyOTPurl),
        headers: {"Authorization": "Bearer $accessToken"},
      );
      log(response.body.toString(), name: "verify otp");
      log(response.statusCode.toString(), name: "verify otp statuscode");
      Get.back();
      final statusCode = jsonDecode(response.body)["statusCode"];

      if (statusCode == 200) {
        log(response.body.toString(), name: "verify otp");
        Get.to(OTPSuccessScreen(screenName: false));
      }else{
        Get.snackbar("OTP is not valid",
            "OTP you entered didn't match with the once sent to you",
            backgroundColor: kPrimaryColor, colorText: kWhiteColor);
      }
    } catch (e) {
      Get.back();

      log("Error while verifying otp to mobile number $e");
    }
  }
}
