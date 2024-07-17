import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/profile/model/allergies_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class GetIngredientApiServices {
  final storage = FlutterSecureStorage();
  Future<List<AllergiesModel>> fetchIngredient() async {
    final url = "${ApiConfig.baseUrl}${ApiConfig.ingredient}";
    log(url.toString(), name: "ingredient");
    final accessToken = await storage.read(key: "access_token");
    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $accessToken"},
    );
    if (response.statusCode == 200) {
      log(response.body.toString(), name: "ingredient");
      final List<dynamic> responseData = json.decode(response.body)["payload"];
      final List<AllergiesModel> ingredient =
          responseData.map((json) => AllergiesModel.fromJson(json)).toList();
      return ingredient;
    } else {
      throw Exception("failed to load profile data");
    }
  }
}
