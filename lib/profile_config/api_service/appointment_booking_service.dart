import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentBookingApiServices {
  final storage = FlutterSecureStorage();
  final String url = ApiConfig.baseUrl + ApiConfig.appointmentBooking;
  final signUpController = Get.find<SignUpController>();

  Future<void> appointmentBooking() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final mobile = await prefs.getString("mobile");
    final accessToken = await storage.read(key: "access_token");
    try {
      log("${signUpController.mobileNumber}", name: "user mobile number");
      final response = await http.post(Uri.parse(url),
          body: json.encode({"mobile": "$mobile"}),
          headers: {"Authorization": "Bearer $accessToken"});
      log("${Uri.parse(url)}", name: "request url");
      log("${response.statusCode}", name: "response statusCode");
      log("${response.body}", name: "response body");

      if (response.statusCode == 200) {
        toast(
            "    Appointment booked successfully...\nOur Customer service will reach you out",
            duration: Toast.LENGTH_LONG);

        log(response.body, name: "appointment booking");
      }
    } catch (e) {
      log("failed to book appointment $e");
    }
  }
}
