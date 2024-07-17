import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/auth/login/view/login_screen.dart';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetAccessTokenService {
  final storage = const FlutterSecureStorage();

  String? _accessToken;
  String? get accessToken => _accessToken;

  Future<void> getAccessToken() async {
    String url =
        "${ApiConfig.baseUrl}${ApiConfig.accessToken}?client_id=${ApiConfig.clientId}&client_secret=${ApiConfig.secretKey}";
    try {
      Get.dialog(Center(child: CircularProgressIndicator()));
      final response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        _accessToken = jsonDecode(response.body)["payload"][0]["access_token"];
        await storage.write(key: "access_token", value: _accessToken);
        log(response.body);
      } else {
        log("Failed to fetch access token. status code: ${response.statusCode}${response.body}");
      }
    } catch (e) {
      Get.back();
      log("Error fetching access token: $e}");
    } finally {
      Get.back();
    }
  }
}
