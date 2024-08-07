import 'dart:convert';
import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/auth/sign_up/model/area_&_block_model.dart';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetAreaAndBlockAPiServices {
  final storage = FlutterSecureStorage();
  final controller = Get.find<SignUpController>();
  List<Map<String, dynamic>> areas = [];
  List<Map<String, dynamic>> bloc = [];
  Future<List<GetAreaModel>> fetchArea() async {
    final accessToken = await storage.read(key: "access_token");
    final url = ApiConfig.baseUrl + ApiConfig.area;

    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $accessToken"});

    if (response.statusCode == 200) {
      // log(response.body.toString());
      final List<dynamic> responseData = json.decode(response.body)["payload"];
      final List<GetAreaModel> areas =
          responseData.map((e) => GetAreaModel.fromJson(e)).toList();
      return areas;
    } else {
      throw Exception("failed to fetch areas");
    }
  }

  Future<List<GetBlockModel>> fetchBlock(int area) async {
    final accessToken = await storage.read(key: "access_token");
    final url = ApiConfig.baseUrl + ApiConfig.block+"?area=$area";

    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $accessToken"});

    if (response.statusCode == 200) {
      // log(response.body.toString());
      // print("fetchBlock");
      // print(url);
      final List<dynamic> responseData = json.decode(response.body)["payload"];
      // print("fetchBlock");

      final List<GetBlockModel> areas =
          responseData.map((e) => GetBlockModel.fromJson(e)).toList();
      return areas;
    } else {
      throw Exception("failed to fetch areas");
    }
  }
}
