import 'dart:convert';
import 'dart:developer';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/profile_config/controller/subscription_plan_controller.dart';
import 'package:diet_diet_done/profile_config/model/coupon_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CouponVerificationApiServices {
  final storage = FlutterSecureStorage();
  final controller = Get.find<SubscriptionPlanController>();

  Future<List<CouponModel>> verifyCoupon() async {
    final url =
        '${ApiConfig.baseUrl}${ApiConfig.coupon}?plan_choice_id=${controller.subscriptionId}&coupon_code=${controller.couponController.text}';
    final accessToken = await storage.read(key: "access_token");

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      log(response.body, name: "coupon success");
      final message = jsonDecode(response.body)["error"];
      final statusOk = jsonDecode(response.body)["statusOk"];
      final error = jsonDecode(response.body)["error"];
      if (statusOk == true) {
        Get.snackbar("Successful", "Coupon added successfully..");
      }
      if (message == "Invalid coupon code.") {
        Get.snackbar("Invalid Coupon", "please re-check and try again");
      }
      if (error == "Coupon code not passed.") {
        Get.snackbar("Enter Coupon Code", "Coupon code not passed.");
      }
      final List<dynamic> responseData = json.decode(response.body)["payload"];
      final List<CouponModel> coupons =
          responseData.map((e) => CouponModel.fromJson(e)).toList();

      return coupons;
    } else {
      throw Exception("failed to load plan categories");
    }
  }
}
