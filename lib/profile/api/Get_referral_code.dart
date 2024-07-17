import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GetReferralCodeApiServcie {
  final storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> getReferralCode() async {
    final accessToken = await storage.read(key: "access_token");
    final prefs = await SharedPreferences.getInstance();
    final mobile = await prefs.getString("mobile");
    final url = "${ApiConfig.baseUrl}${ApiConfig.refferalCOde}?mobile=$mobile";
    try {
      final response = await http.get(Uri.parse(url),
          headers: {"Authorization": "Bearer $accessToken"});

      if (response.statusCode == 200) {
        log(response.body, name: "referral code");
        final refferralCode =
            jsonDecode(response.body)["payload"][0]["referral_code"];
        final refferralEarning =
            jsonDecode(response.body)["payload"][0]["referral_earnings"];
        log(refferralCode, name: "refferal code");
        log(refferralEarning.toString(), name: "refferal Earning");
        return {
          "referralCode": refferralCode,
          "refferelEarning": refferralEarning
        };
      } else {
        throw Exception("Error while fetching refferal code.");
      }
    } catch (e) {
      log("error while fetching Referral $e");
      throw Exception("Error while fetching refferal code.");
    }
  }

  Future<Map<String, dynamic>> referralSharing() async {
    final accessToken = await storage.read(key: "access_token");
    final prefs = await SharedPreferences.getInstance();
    final mobile = await prefs.getString("mobile");
    final url = "${ApiConfig.baseUrl}${ApiConfig.refferalCOde}?mobile=$mobile";
    try {
      final response = await http.get(Uri.parse(url),
          headers: {"Authorization": "Bearer $accessToken"});

      if (response.statusCode == 200) {
        log(response.body, name: "referral code");
        final refferralCode =
            jsonDecode(response.body)["payload"][0]["referral_code"];
        final refferralEarning =
            jsonDecode(response.body)["payload"][0]["referral_earnings"];
        log(refferralCode, name: "refferal code");
        log(refferralEarning.toString(), name: "refferal Earning");
        return {
          "referralCode": refferralCode,
          "refferelEarning": refferralEarning
        };
      } else {
        throw Exception("Error while fetching refferal code.");
      }
    } catch (e) {
      log("error while fetching Referral $e");
      throw Exception("Error while fetching refferal code.");
    }
  }
}
