import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/calendar_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetCalendarDatesApiService {
  final storage = FlutterSecureStorage();
  final calendarController = Get.find<CalendarController>();

  Future<void> getCalendarDates() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final mobile = await preferences.getString("mobile");
    final url = "${ApiConfig.baseUrl}${ApiConfig.calendar}?mobile=$mobile";
    log(url);
    final accessToken = await storage.read(key: "access_token");
    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $accessToken"});

    log(response.body.toString(),name: "getCalendarDates");
    if (response.statusCode == 200) {
      final Map<String, dynamic> payload = jsonDecode(response.body)["payload"]??{};
      calendarController.SubscriptionActiveDates.value = payload;
      log(calendarController.SubscriptionActiveDates.toString(),
          name: "SubscriptionActiveDates");
    } else {
      log("Error while fetching calendar dates");
    }
  }
}
