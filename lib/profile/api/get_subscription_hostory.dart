import 'dart:convert';
import 'dart:developer';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/profile/model/subscription_history_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetSubscriptionHistoryApiService {
  final storage = FlutterSecureStorage();

  Future<List<SubscriptionHistoryModel>> getSubscriptionHistory() async {
    final accessToken = await storage.read(key: "access_token");
    final prefs = await SharedPreferences.getInstance();
    final mobile = prefs.getString("mobile");
    final url = "${ApiConfig.baseUrl}${ApiConfig.subscriptionHistory}$mobile";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $accessToken"},
      );

      if (response.statusCode == 200) {
        log(response.body, name: "Subscription History");

        final List<dynamic> payload = jsonDecode(response.body)["payload"];
        final subs = payload
            .map((data) => SubscriptionHistoryModel.fromJson(data))
            .toList();

        return subs;
      } else {
        throw Exception("Error fetching subscription history.");
      }
    } catch (e) {
      log("Error while fetching subscription history: $e");
      throw Exception("Error fetching subscription history.");
    }
  }
}
