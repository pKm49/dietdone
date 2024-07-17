import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/diet_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../core/api/const_api_endpoints.dart';

class SubmitSelectedMealApiService {
  final url = ApiConfig.baseUrl + ApiConfig.submitMeal;
  final storage = FlutterSecureStorage();
  final dietMenuController = Get.find<DietMenuController>();

  Future submitSelectedMeal(
      int subId, List mealCategoryId, List mealIdx, selectedDate) async {
    log(mealIdx.toString(), name: "meal id");
    log(mealCategoryId.toString(), name: "meal category id");
    log(subId.toString(), name: "subscription id");

    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      ),
      barrierDismissible: false,
    );

    final accessToken = await storage.read(key: "access_token");
    final formatSelectedDate = DateFormat("yyyy-MM-dd").format(selectedDate);

    List<Map<String, List<int>>> mealConfig = [];
    for (int i = 0; i < mealCategoryId.length; i++) {
      mealConfig.add({mealCategoryId[i].toString(): mealIdx[i]});
    }
    log(mealConfig.toString(), name: "meal submitting map");
    final response = await http.patch(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $accessToken"},
      body: json.encode({
        "subscription_id": subId,
        "date": formatSelectedDate,
        "meal_config": mealConfig,
      }),
    );

    Get.back();
    log(response.body, name: "submit selected meal");

    if (response.statusCode == 200) {
      Get.back();
      log(response.body, name: "submit selected meal");
      dietMenuController.mealCategoryIdx.clear();
      Get.snackbar("Order confirmed..", "Selected Meals");
    }
  }
}
