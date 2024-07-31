import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/auth/sign_up/view/otp_succuss_screen.dart';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/profile_config/controller/plan_categories_controller.dart';
import 'package:diet_diet_done/profile_config/controller/subscription_plan_controller.dart';
import 'package:diet_diet_done/profile_config/model/subscription_deatils_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateSubscriptionAPiService {
  final signUpController = Get.find<SignUpController>();
  final planController = Get.find<PlanCategoriesController>();
  final subscriptionController = Get.find<SubscriptionPlanController>();

  final storage = FlutterSecureStorage();

  Future createSubscription() async {
    final signUpController = Get.find<SignUpController>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final mobile = await prefs.getString("mobile");
    final accessToken = await storage.read(key: "access_token");

    // Validate parameters
    if (mobile == null || accessToken == null) {
      toast("Mobile number or access token is missing");
      return;
    }

    final url = "${ApiConfig.baseUrl}${ApiConfig.createSubscription}";
    final headers = {"Authorization": "Bearer $accessToken"};
    final body = json.encode({
      "mobile": mobile,
      "plan_id": planController.planId,
      "plan_choice_id": subscriptionController.subscriptionId.value,
      "start_date": subscriptionController.selectedDate,
      "promo_code": subscriptionController.couponController.text
    });

    log(mobile, name: "mobile number");
    log(planController.planId.toString(), name: "plan_id");
    log(subscriptionController.subscriptionId.value.toString(),
        name: "plan_choice_id");
    log(subscriptionController.selectedDate.toString(), name: "selected date");

    log("URL: $url");
    log("Headers: $headers");
    log("Body: $body");

    try {
      Get.dialog(
        Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        ),
        barrierDismissible: false,
      );

      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      log("Response status: ${response.statusCode}");
      log("Response body: ${response.body}");

      final statusCode = jsonDecode(response.body)["statusCode"];
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final errorMessage = responseBody["error"];
        if (responseBody["payload"] != null) {
        if (responseBody["payload"].length > 0) {
          subscriptionController.transactionUrl.value =
          responseBody["payload"][0]["transaction_url"];
          subscriptionController.redirectUrl.value =
          responseBody["payload"][0]["redirect_url"];
          subscriptionController.paymentUrl.value =
          responseBody["payload"][0]["payment_reference"];

          subscriptionController
              .updatePaymentData(responseBody["payload"][0]["transaction_url"]);
          log(subscriptionController.transactionUrl.value,
              name: "transaction url name");
          return statusCode;
        }
      }else{

          toast(
            errorMessage,
          );
          return;
        }

      } else {

        throw Exception(
            "Failed to create subscription: ${response.statusCode}");
      }
    } catch (e,str) {
      Get.snackbar("Failed to create subscription",
          "Sorry, we couldn't create subscription, please contact customer support or try again",
          backgroundColor: kPrimaryColor, colorText: kWhiteColor);
    } finally {
      Get.back();
    }
  }

  Future<List<SubscriptionDetailsModel>> getSubscriptionDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final mobile = await prefs.getString("mobile");
    final accessToken = await storage.read(key: "access_token");

    if (mobile == null || accessToken == null) {
      throw Exception("Mobile number or access token is missing");
    }

    final url = "${ApiConfig.baseUrl}${ApiConfig.createSubscription}/$mobile";
    final headers = {"Authorization": "Bearer $accessToken"};

    log("Get Subscription Details URL: $url");

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)["payload"];
      return responseData
          .map((e) => SubscriptionDetailsModel.fromJson(e))
          .toList();
    } else {
      throw Exception(
          "Failed to get subscription details: ${response.statusCode}");
    }
  }

  void checkOrderStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final mobile = await prefs.getString("mobile");
    final accessToken = await storage.read(key: "access_token");

    if (mobile == null || accessToken == null) {
      throw Exception("Mobile number or access token is missing");
    }

    final url = "${ApiConfig.baseUrl}${ApiConfig.checkSubPaymentStatus}?reference=${subscriptionController.paymentUrl.value}";
    final headers = {"Authorization": "Bearer $accessToken"};

    log("Get Subscription Details URL: $url");



    try {
      Get.dialog(
        Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        ),
        barrierDismissible: false,
      );

      final response = await http.get(Uri.parse(url), headers: headers);

      log("Response status: ${response.statusCode}");
      log("Response body: ${response.body}");

      final statusCode = jsonDecode(response.body)["statusCode"];
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final errorMessage = responseBody["error"];
        if (responseBody["payload"] != null) {
          if(responseBody["payload"][0]['payment_status'] =="paid" ){
            Get.off(const OTPSuccessScreen(screenName: true));
          } else{
            throw Exception(
                "Failed to capture payment: ${response.statusCode}");
          }
        }else{
          throw Exception(
              "Failed to capture payment: ${response.statusCode}");
        }

      } else {

        throw Exception(
            "Failed to capture payment: ${response.statusCode}");
      }
    } catch (e,str) {
      Get.back();
      Get.snackbar("Failed to capture payment",
          "Sorry, we couldn't capture payment, please contact customer support or try again",
          backgroundColor: kPrimaryColor, colorText: kWhiteColor);

    }
  }
}
