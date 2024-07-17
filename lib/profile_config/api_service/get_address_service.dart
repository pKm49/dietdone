import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/profile_config/controller/profile_config_controller.dart';
import 'package:diet_diet_done/profile_config/model/get_address_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetAddressApiServices {
  final controller = Get.find<ProfileConfigController>();

  final storage = FlutterSecureStorage();
  Future<List<GetAddressModel>> fetchAddressData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final mobile = await prefs.getString("mobile");
    final accessToken = await storage.read(key: "access_token");
    final String url =
        "${ApiConfig.baseUrl + ApiConfig.address}?mobile=$mobile";
    try {
      final response = await http.get(Uri.parse(url),
          headers: {"Authorization": "Bearer $accessToken"});

      if (response.statusCode == 200) {
        log(response.body.toString());
        if (response.statusCode == 200) {
          final List<dynamic> responseData =
              json.decode(response.body)["payload"];

          final List<GetAddressModel> addresses = responseData
              .map((json) => GetAddressModel.fromJson(json))
              .toList();
          return addresses;
        } else {
          throw Exception('Failed to fetch address get: }');
        }
      } else {
        throw Exception(
            'Failed to fetch data, status code: ${response.statusCode}');
      }
    } catch (e) {
      log("Failed to fetch data: $e", name: "error");
      return [];
    }
  }
}
