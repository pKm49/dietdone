import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/diet_delivery/calendar/api/get_calendar_dates_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FreezeDateApiService {
  final url = ApiConfig.baseUrl + ApiConfig.freeze;
  final storage = FlutterSecureStorage();
  Future freezeSubscription(int subId, List selectedFreezedDate) async {
    Get.dialog(
        Center(
            child: CircularProgressIndicator(
          color: kPrimaryColor,
        )),
        barrierDismissible: false);
    final accessToken = await storage.read(key: "access_token");
    final response = await http.patch(Uri.parse(url),
        headers: {"Authorization": "Bearer $accessToken"},
        body: json.encode({
          "subscription_id": subId,
          "freeze_dates": selectedFreezedDate,
        }));
    final statusCode = json.decode(response.body)["statusCode"];

    log(response.body, name: "freeze");
    if (statusCode == 200) {
      log(response.body, name: "freeze");
      await GetCalendarDatesApiService().getCalendarDates();

      Get.back();
    }
    Get.back();
  }
}
