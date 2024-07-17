import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/profile_config/model/get_subscription_plan_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class GetSubscriptionPlanApiService {
  final storage = FlutterSecureStorage();
  Future<List<GetSubscriptionPlanModel>> fetchSubscriptionPlan(
      String planId) async {
    final accessToken = await storage.read(key: "access_token");
    final String url = ApiConfig.baseUrl + ApiConfig.subscription + planId;

    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $accessToken"});
    if (response.statusCode == 200) {
      log(response.body.toString(), name: "subscription");
      final List<dynamic> responseData = json.decode(response.body)["payload"];
      final List<GetSubscriptionPlanModel> subscriptions = responseData
          .map((e) => GetSubscriptionPlanModel.fromJson(e))
          .toList();
      return subscriptions;
    } else {
      log("same error", name: "subscription");
      throw Exception("failed to fetch subscription plans");
    }
  }
}
