import 'dart:convert';
import 'dart:developer';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/profile/view/profile_screen.dart';
import 'package:diet_diet_done/profile_config/controller/address_controller.dart';
import 'package:diet_diet_done/profile_config/controller/profile_config_controller.dart';
import 'package:diet_diet_done/profile_config/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CreateAddressApiServices {
  final controller = Get.find<ProfileConfigController>();
  final storage = FlutterSecureStorage();
  Future<void> createNewAddress(CreateAddressModel model) async {
    final accessToken = await storage.read(key: "access_token");
    final url = "${ApiConfig.baseUrl + ApiConfig.address}";
    final header = {"Authorization": "Bearer $accessToken"};
    log(url.toString());
    try {
      final response = await http.post(Uri.parse(url),
          headers: header, body: json.encode(model));
      log("here");
      log(response.body);
      if (response.statusCode == 200) {
        log(response.body.toString());
        Get.off(ProfileScreen());
      }
    } catch (e) {
      log(e.toString(), name: "error");
    }
  }

  Future<void> updateAddress(model) async {
    final addressController = Get.find<AddressController>();
    Get.dialog(
        Center(
            child: CircularProgressIndicator(
          color: kPrimaryColor,
        )),
        barrierDismissible: false);
    final accessToken = await storage.read(key: "access_token");
    final url = "${ApiConfig.baseUrl + ApiConfig.address}";
    final header = {"Authorization": "Bearer $accessToken"};
    log(url.toString());
    try {
      print("new address body");
      print(json.encode(model).toString());
      final response = await http.patch(Uri.parse(url),
          headers: header, body: json.encode(model));
      log("here");
      log(response.body, name: "error update address");
      if (response.statusCode == 200) {
        log(response.body.toString(), name: "update address");
        await addressController.fetchAddress();
        Get.back();
      }
    } catch (e) {
      log(e.toString(), name: "error");
    } finally {
      Get.back();
    }
  }
}
