import 'dart:convert';
import 'dart:developer';
import 'package:diet_diet_done/auth/login/controller/login_controller.dart';
import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/diet_delivery/home/view/bottom_navigation_bar.dart';
import 'package:diet_diet_done/diet_delivery/home/view/meal_selecting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginApiService {
  final controller = Get.find<LoginController>();
  final signUpController = Get.find<SignUpController>();
  final storage = FlutterSecureStorage();

  Future<void> userLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final url =
        '${ApiConfig.baseUrl}${ApiConfig.login}?mobile=${controller.phoneNumberController.text.trim()}&password=${controller.passwordController.text.trim()}';
    final accessToken = await storage.read(key: "access_token");
    try {
      Get.dialog(
          Center(
              child: CircularProgressIndicator(
            color: kPrimaryColor,
          )),
          barrierDismissible: false);

      log(url);
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      log(response.body, name: "response body");
      Get.back();
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        final statusOk = responseData['statusOk'] ?? false;
        final statusCode = responseData['statusCode'];

        if (statusOk && statusCode == 200) {
          await prefs.setBool("isLoggedIn", true);
          await prefs.setString("mobile", signUpController.mobileNumber!);
          Get.to(const BottomNavBar());
          // Get.to(const MealSelectionScreen());
        } else {
          await prefs.setString("mobile", "");

          final errorMessage = responseData['error'] ?? "Unknown error";
          Get.snackbar("Oops..", errorMessage,
              backgroundColor: kPrimaryColor, colorText: kWhiteColor);
        }
      } else {
        await prefs.setString("mobile", "");

        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final errorMessage = responseData['error'] ?? "Unknown error";
        Get.snackbar("Oops..", errorMessage,
            backgroundColor: kPrimaryColor, colorText: kWhiteColor);
      }
    } catch (e) {
      await prefs.setString("mobile", "");

      log(e.toString(), name: "error");
    }
  }
}
