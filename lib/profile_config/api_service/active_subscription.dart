import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/diet_delivery/home/view/bottom_navigation_bar.dart';
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
    if(subscriptionController.subscriptionDetails.where((p0) => p0.subscriptionStatus=='paid').toList().isNotEmpty){
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
              subscriptionController.subscriptionDetails.where((p0) => p0.subscriptionStatus=='paid').toList().isNotEmpty?
              subscriptionController.subscriptionDetails.where((p0) => p0.subscriptionStatus=='paid').toList()[0].subscriptionId:1
            }));
        print("activeSubscription");
        print(subscriptionController.subscriptionDetails[0].subscriptionId);
        print(json.encode({
          "subscription_id":
          subscriptionController.subscriptionDetails[0].subscriptionId
        }));
        if (response.statusCode == 200) {
          print("Success while activating subscription");
          log(response.body);
         await subscriptionController.getSubscriptionDetails(false);
          Get.offAll(BottomNavBar());
        } else {
          print("Error while activating subscription");
        }
      } catch (e) {
        print("Error while Activating Subscription: $e");
      } finally {
        print("activate subscription finally called");
        Get.back();
      }
    }else{
     await subscriptionController.getSubscriptionDetails(false);
      Get.offAll(BottomNavBar());
    }

  }
}
