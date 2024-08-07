import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/auth/sign_up/model/create_profile_model.dart';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/diet_delivery/home/controller/getProfileController.dart';

import 'package:diet_diet_done/profile_config/view/plan_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUpApiServices {
  final storage = FlutterSecureStorage();
  final controller = Get.find<SignUpController>();

  Future checkUserLogged(mobile, password) async {
    final accessToken = await storage.read(key: "access_token");
    try {
      final response = await http.post(
          Uri.parse(ApiConfig.baseUrl + ApiConfig.profile),
          headers: {"Authorization": "Bearer $accessToken"},
          body: json.encode({"mobile": mobile, "password": password}));
      log(controller.passwordController.text, name: "pass");
      log(controller.phoneNumberController.text, name: "phone");

      log(response.body.toString());
      if (response.statusCode == 200) {
        log(response.body.toString());
      } else {
        log("Error while login");
      }
    } catch (e) {
      log("failed to login $e");
    }
  }

  Future createNewProfile(CreateProfileModel profileModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final signUpController = Get.find<SignUpController>();
    final accessToken = await storage.read(key: "access_token");
    final model = profileModel.toJson();

    log(model.toString(), name: "jasir ali");
    try {
      Get.dialog(
          Center(
              child: CircularProgressIndicator(
            color: kPrimaryColor,
          )),
          barrierDismissible: false);
      final response = await http.post(
        Uri.parse(ApiConfig.baseUrl + ApiConfig.profile),
        headers: {"Authorization": "Bearer $accessToken"},
        body: json.encode(model),
      );

      log(response.body.toString(), name: "here");
      if (response.statusCode == 200) {
        Get.back();
        log(response.body.toString(), name: "status 200");
        log(signUpController.mobileNumber!,
            name: "sign up controller mobile number.........");
        await prefs.setString("mobile", signUpController.mobileNumber!);
        log(signUpController.phoneNumberController.text,
            name: "phone number saving to mobile");
        Get.offAll(PlanSelectionScreen());
      }else{
        Get.back();
      }
    } catch (e) {
      Get.back();

      log(e.toString());
    }
  }

  Future UpdateUserProfile(mobile, lastName, name, email, profilePicture) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final signUpController = Get.find<SignUpController>();
    final accessToken = await storage.read(key: "access_token");
    final profileController = Get.find<GetProfileController>();
    try {
      print("profilePicture");
      print(profilePicture);
      Get.dialog(
          Center(
              child: CircularProgressIndicator(
            color: kPrimaryColor,
          )),
          barrierDismissible: false);
      final response = await http.patch(
        Uri.parse(ApiConfig.baseUrl + ApiConfig.profile),
        headers: {"Authorization": "Bearer $accessToken"},
        body:profilePicture!=null? json.encode({
          "mobile": mobile,
          "last_name": lastName,
          "first_name": name,
          "email": email,
          "profile_picture":profilePicture
        }):json.encode({
          "mobile": mobile,
          "last_name": lastName,
          "first_name": name,
          "email": email,
        }),
      );
      Get.back();
      log(response.body.toString(), name: "here");
      final statusCode = jsonDecode(response.body)["statusCode"];
      log(statusCode.toString(), name: "updateUser Profile status code");
      if (statusCode == 200) {
        Get.snackbar("Successful", "Profile updated successfully..",backgroundColor: kPrimaryColor, colorText: kWhiteColor);

        await profileController.fetchProfileData();
        log(response.body.toString(), name: "updated User profile");
        log(signUpController.mobileNumber!,
            name: "sign up controller mobile number.........");
        await prefs.setString("mobile", signUpController.mobileNumber!);

        Get.back();

      }
    } catch (e) {
      Get.back();
      log(e.toString());
    }
  }
}
