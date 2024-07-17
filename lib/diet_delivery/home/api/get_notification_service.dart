import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/diet_delivery/home/model/notification_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetNotificationApiService {
  final storage = FlutterSecureStorage();
  final signUpController = Get.find<SignUpController>();

  Future<List<NotificationModel>> fetchNotification() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final mobileNumber = preferences.getString("mobile");
    log(mobileNumber.toString(), name: "local storage saved mobile number");
    final accessToken = await storage.read(key: "access_token");

    final url = "${ApiConfig.baseUrl}${ApiConfig.notification}$mobileNumber";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $accessToken"},
      );

      if (response.statusCode == 200) {
        log(response.body.toString(), name: "notification response");
        final List<dynamic> responseData =
            json.decode(response.body)["payload"];
        final List<NotificationModel> notification =
            responseData.map((e) => NotificationModel.fromJson(e)).toList();

        return notification;
      } else {
        throw Exception(
            "Error: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } on SocketException catch (e) {
      log("Network error while fetching notification: $e");
      throw Exception("Network error");
    } catch (error) {
      log("Error while fetching notification: $error");
      rethrow;
    }
  }
}
