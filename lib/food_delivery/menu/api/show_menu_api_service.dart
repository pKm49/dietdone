import 'dart:convert';
import 'dart:developer';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/food_delivery/menu/controller/Menu_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ShowMenuApiService {
  final storage = FlutterSecureStorage();
  final url = ApiConfig.baseUrl + ApiConfig.showMenu;
  final menuController = Get.find<MenusController>();

  Future showMenu() async {
    menuController.showMenu.value = false;
    // final accessToken = await storage.read(key: "access_token");
    // try {
    //   final response = await http.get(Uri.parse(url),
    //       headers: {"Authorization": "Bearer $accessToken"});
    //   log(response.body, name: "Show menu");
    //   if (response.statusCode == 200) {
    //     log(response.body, name: "Show menu");
    //     final List<dynamic> payload = json.decode(response.body)["payload"];
    //     final show_menu = payload[0]["show_shop"];
    //     menuController.showMenu.value = false;
    //     // log(menuController.showMenu.toString(), name: "IsMenuOnOrOFF");
    //     // menuController.showMenu.value = (show_menu=="True"||show_menu=="true"||
    //     //     show_menu=="Yes"||show_menu=="yes")?true:false;
    //     // log(menuController.showMenu.toString(), name: "IsMenuOnOrOFF");
    //     return show_menu;
    //   } else {
    //     throw Exception("Error while fetching show_menu");
    //   }
    // } catch (e,str) {
    //   log("catch error on show_menu $str");
    // }
  }
}
