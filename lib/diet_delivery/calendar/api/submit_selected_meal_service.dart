import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/diet_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import '../../../core/api/const_api_endpoints.dart';

class SubmitSelectedMealApiService {
  final url = ApiConfig.baseUrl + ApiConfig.submitMeal;
  final storage = FlutterSecureStorage();
  final dietMenuController = Get.find<DietMenuController>();

  Future submitSelectedMeal(
      int subId, List mealCategoryId, List mealIdx,DateTime selectedDate) async {
    try{
      toast("submitSelectedMeal api triggered");

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
      print( "meal submitting pre data");
      print(mealCategoryId.toString());
      print(mealIdx.toString());
      print(formatSelectedDate);
      Map<String, List<int>> mealConfig = {};
      List<Map<String, List<int>>> mealConfigList = [];
      for (int i = 0; i < mealCategoryId.length; i++) {
        mealConfig.addAll({mealCategoryId[i].toString(): mealIdx[i]});
      }
      mealConfigList.add(mealConfig);
      print( "meal submitting map");
      print(mealConfig.toString());
      print([mealConfig]);
      final response = await http.patch(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $accessToken"},
        body: json.encode({
          "subscription_id": subId,
          "date": formatSelectedDate,
          "meal_config": mealConfigList,
        }),
      );

      Get.back();
      log(response.body, name: "submit selected meal");

      if (response.statusCode == 200) {
        Get.back();
        log(response.body, name: "submit selected meal");
        dietMenuController.mealCategoryIdx.clear();
        dietMenuController.selectedCalories.value = 0.0;
        Get.snackbar("Order confirmed..", "Selected Meals",backgroundColor: kPrimaryColor, colorText: kWhiteColor);
      }
    }catch(e,st){
      toast("SubmitSelectedMealApiService" );
      log(e.toString() );
      log(st.toString() );

      Get.back();
    }

  }
}
