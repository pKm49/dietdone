import 'dart:convert';
import 'dart:developer';

import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/profile/controller/Profile_controller.dart';
import 'package:diet_diet_done/profile/model/allergies_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateAllergiesAPiServices {
  final profileController = Get.find<ProfileController>();
  final storage = FlutterSecureStorage();
  final url = ApiConfig.baseUrl + ApiConfig.allergy;
  updateAllergies(List selectedAllergies) async {
    final prefs = await SharedPreferences.getInstance();
    final mobileNumber = await prefs.getString('mobile');
    log(mobileNumber.toString());
    final accessToken = await storage.read(key: "access_token");
    final response = await http.patch(Uri.parse(url),
        headers: {"Authorization": "Bearer $accessToken"},
        body: json.encode(
            {"mobile": "$mobileNumber", "allergies": selectedAllergies}));
    int statusCode = json.decode(response.body)["statusCode"];
    if (statusCode == 200) {
      log(response.body, name: "allergies");
      // profileController.selectedOptions.clear();
      // profileController.selectedOptionIds.clear();
      Get.snackbar("Updated...", "Successfully updated your allergies",backgroundColor: kPrimaryColor, colorText: kWhiteColor);
    }
  }

  getUpdatedAllergies() async {
    final prefs = await SharedPreferences.getInstance();
    final mobileNumber = await prefs.getString('mobile');
    final accessToken = await storage.read(key: "access_token");
    final getUrl =
        "${ApiConfig.baseUrl + ApiConfig.allergy}?mobile=$mobileNumber";

    final response = await http.get(
      Uri.parse(getUrl),
      headers: {"Authorization": "Bearer $accessToken"},
    );
    int statusCode = json.decode(response.body)["statusCode"];
    if (statusCode == 200) {
      log(response.body, name: "Get allergies");
      final List<dynamic> payload = jsonDecode(response.body)["payload"];
      log(payload.toString(), name: "allergies payload");
      for (var i = 0; i < payload.length; i++) {
        log(payload[i]["id"].toString(), name: "allergies payload");
        profileController.selectedOptions.add(AllergiesModel(id: payload[i]["id"]??"",
            name: payload[i]["name"]??"", arabicName: payload[i]["arabic_name"]??""));
        log(profileController.selectedOptions.toString());
      }
    }
  }
}
