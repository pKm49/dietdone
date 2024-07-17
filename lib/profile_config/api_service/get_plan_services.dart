import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/profile_config/model/get_plan_categories_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class GetPlanCategoriesAPiServices {
  final storage = FlutterSecureStorage();
  final String url = ApiConfig.baseUrl + ApiConfig.planCategories;
  Future<List<GetPlanCategoriesModel>> fetchPlanCategories() async {
    final accessToken = await storage.read(key: "access_token");
    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $accessToken"});
    log(response.body, name: "subscription Plans");

    if (response.statusCode == 200) {
      log(response.body);
      final List<dynamic> responseData = json.decode(response.body)["payload"];
      final List<GetPlanCategoriesModel> plans = responseData
          .map((json) => GetPlanCategoriesModel.fromJson(json))
          .toList();
      return plans;
    } else {
      throw Exception("failed to load plan categories");
    }
  }
}
