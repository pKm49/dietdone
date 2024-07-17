import 'dart:convert';
import 'dart:developer';
import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/diet_delivery/home/model/get_profile_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class GetProfileService {
  final storage = FlutterSecureStorage();
  final signUpController = Get.find<SignUpController>();
  Future<List<GetProfileModel>> fetchProfile() async {
    log(signUpController.mobileNumber.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final mobile = await prefs.getString("mobile");
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // signUpController.mobileNumber = preferences.getString("mobileNumber");
    final url = "${ApiConfig.baseUrl}${ApiConfig.profile}?mobile=$mobile";
    log(url.toString(), name: "get profile url");
    final accessToken = await storage.read(key: "access_token");
    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $accessToken"},
    );
    if (response.statusCode == 200) {
      log(response.body.toString(), name: "Get profile");
      final List<dynamic> responseData = json.decode(response.body)["payload"];
      final List<GetProfileModel> profileData =
          responseData.map((json) => GetProfileModel.fromJson(json)).toList();
      return profileData;
    } else {
      throw Exception("failed to load profile data");
    }
  }
}
