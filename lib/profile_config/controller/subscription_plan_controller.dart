import 'dart:developer';

import 'package:diet_diet_done/auth/sign_up/view/otp_succuss_screen.dart';
import 'package:diet_diet_done/profile_config/api_service/create_subscription_service.dart';
import 'package:diet_diet_done/profile_config/api_service/get_subscription_plan_service.dart';
import 'package:diet_diet_done/profile_config/controller/plan_categories_controller.dart';
import 'package:diet_diet_done/profile_config/model/get_subscription_plan_model.dart';
import 'package:diet_diet_done/profile_config/model/subscription_deatils_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SubscriptionPlanController extends GetxController {
  RxString referenceId = ''.obs;
  RxString orderId = ''.obs;
  RxString transactionUrl = ''.obs;
  RxString redirectUrl = ''.obs;
  RxString paymentUrl = ''.obs;
  RxString paymentCheckUrl = ''.obs;

  RxBool isSelectedSubscriptionCard = false.obs;
  RxInt subscriptionId = 0.obs;
  RxInt subscriptionCardIdx = 0.obs;
  RxList<SubscriptionDetailsModel> subscriptionDetails =
      <SubscriptionDetailsModel>[].obs;
  String selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String selectedStartingDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
  DateTime dateTimeNow = DateTime.now();
  Rx<TextEditingController> couponController = TextEditingController().obs;

  RxList<GetSubscriptionPlanModel> subscriptionPlan =
      <GetSubscriptionPlanModel>[].obs;
  RxBool isLoading = false.obs;
  final planCategoriesController = Get.find<PlanCategoriesController>();
  @override
  void onInit() async {
    await fetchSubscriptionPlan();

    super.onInit();
  }

  updatePaymentData(transaction) {
    transactionUrl.value = transaction;
    log(transactionUrl.value, name: "update payment Date");
  }

  Future<void> fetchSubscriptionPlan() async {
    try {
      isLoading.value = true;
      final plans = await GetSubscriptionPlanApiService()
          .fetchSubscriptionPlan("${planCategoriesController.planId}");
      subscriptionPlan.value = plans;
    } catch (e) {
      isLoading.value = false;
      log("Error while fetching subscription: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getSubscriptionDetails(bool isNav) async {
    try {
      isLoading.value = true;
      await CreateSubscriptionAPiService()
          .getSubscriptionDetails()
          .then((value) => subscriptionDetails.value = value);

      if(isNav){
        Get.off(const OTPSuccessScreen(screenName: true));
      }

    } catch (e) {
      log("Error while fetching subscription details: $e");
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  void updatCouponcode(String couponCode) {
     couponController.value.text = couponCode;
  }
}
