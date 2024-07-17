import 'dart:convert';
import 'dart:developer';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/diet_menu_controller.dart';
import 'package:diet_diet_done/diet_delivery/calendar/model/diet_meals_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetDietMealsAPiService {
  final storage = FlutterSecureStorage();
  final dietMealsController = Get.find<DietMenuController>();

  Future<List<DietMealsModel>> fetchDietMeal() async {
    final preference = await SharedPreferences.getInstance();
    final mobile = preference.getString("mobile");
    if (mobile == null) {
      throw Exception("Mobile number not found in shared preferences");
    }
    final url = ApiConfig.baseUrl + ApiConfig.dietMeal + mobile;
    final accessToken = await storage.read(key: "access_token");

    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      final List<dynamic> responsePayload =
          jsonDecode(response.body)["payload"];
      return responsePayload.map((e) => DietMealsModel.fromJson(e)).toList();
    } else {
      log("Error response status: ${response.statusCode}, body: ${response.body}");
      throw Exception(
          "Error while fetching Diet meals: ${response.statusCode}");
    }
  }
}
