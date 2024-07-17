import 'dart:developer';

import 'package:diet_diet_done/profile_config/api_service/coupon_verification_api_service.dart';
import 'package:diet_diet_done/profile_config/model/coupon_model.dart';
import 'package:get/get.dart';

class CouponController extends GetxController {
  RxList<CouponModel> couponsList = <CouponModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // CouponVerificationApiServices().verifyCoupon();
    super.onInit();
  }

  void verifyCoupon() async {
    try {
      isLoading.value = true;
      final coupons = await CouponVerificationApiServices().verifyCoupon();
      couponsList.value = coupons;
      log(couponsList.toString(), name: "couponList");
    } catch (e) {
      isLoading.value = false;
      log("Error fetching coupons discounts $e");
    } finally {
      isLoading.value = false;
    }
  }
}
