import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/food_delivery/menu/model/meals_by_id_model.dart';
import 'package:diet_diet_done/food_delivery/menu/model/meals_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class GetMealsAPiService {
  final storage = FlutterSecureStorage();
  Future<List<MealsModel>> fetchMeal() async {
    final url = ApiConfig.baseUrl + ApiConfig.meal;
    final accessToken = await storage.read(key: "access_token");
    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $accessToken"});
    if (response.statusCode == 200) {
      // log(response.body, name: "meals");
      final List<dynamic> responseData = json.decode(response.body)["payload"];
      final meals = responseData.map((e) => MealsModel.fromJson(e)).toList();
      return meals;
    } else {
      throw Exception("Error while fetching meals");
    }
  }

  Future<List<MealsByIdModel>> fetchModelById(String mealsId) async {
    final url = "${ApiConfig.baseUrl}${ApiConfig.meal}/$mealsId";
    final accessToken = await storage.read(key: "access_token");
    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $accessToken"});
    if (response.statusCode == 200) {
      log(response.body, name: "meals by id");
      final List<dynamic> responseData = json.decode(response.body)["payload"];
      final meals =
          responseData.map((e) => MealsByIdModel.fromJson(e)).toList();
      return meals;
    } else {
      throw Exception("Failed to fetch meals by Id");
    }
  }
}
