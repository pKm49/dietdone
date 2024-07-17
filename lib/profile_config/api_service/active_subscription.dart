import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/profile_config/controller/subscription_plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ActiveSubscriptionAPiService {
  final url = ApiConfig.baseUrl + ApiConfig.activeSubscription;
  final subscriptionController = Get.find<SubscriptionPlanController>();
  final storage = FlutterSecureStorage();
  Future activeSubscription() async {
    final accessToken = await storage.read(key: "access_token");
    try {
      Get.dialog(
          Center(
              child: CircularProgressIndicator(
            color: kPrimaryColor,
          )),
          barrierDismissible: false);
      final response = await http.post(Uri.parse(url),
          headers: {"Authorization": "Bearer $accessToken"},
          body: json.encode({
            "subscription_id":
                subscriptionController.subscriptionDetails[0].subscriptionId
          }));
      log(response.body);
      log(
          subscriptionController.subscriptionDetails[0].subscriptionId
              .toString(),
          name: "subscription id..........................");
      if (response.statusCode == 200) {
        log(response.body);
      } else {
        log("Error while activating subscription");
      }
    } catch (e) {
      log("Error while Activating Subscription: $e");
    } finally {
      Get.back();
    }
  }
}
