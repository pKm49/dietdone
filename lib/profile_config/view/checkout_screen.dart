import 'dart:developer';

import 'package:diet_diet_done/auth/sign_up/view/otp_succuss_screen.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/profile_config/api_service/create_subscription_service.dart';
import 'package:diet_diet_done/profile_config/controller/coupon_controller.dart';
import 'package:diet_diet_done/profile_config/controller/plan_categories_controller.dart';
import 'package:diet_diet_done/profile_config/controller/subscription_plan_controller.dart';
import 'package:diet_diet_done/profile_config/view/payment_gateway_webview.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key, required this.subscriptionCardIndex});
  final int subscriptionCardIndex;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subscriptionPlanController = Get.find<SubscriptionPlanController>();
    final couponController = Get.find<CouponController>();
    log(subscriptionPlanController.transactionUrl.value,
        name: "transaction url payment screen");

    final planController = Get.find<PlanCategoriesController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 41,
                height: 41,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: borderColor,
                  ),
                  color: kWhiteColor,
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
            kWidth(20),
            Text(
              "Checkout",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.language,
                      color: kPrimaryColor,
                    )),
                Text(
                  "English",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                ),
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Visibility(

                    child: Text(
                      "Order Reference",
                      style: theme.textTheme.titleLarge,
                    ),
                      visible:subscriptionPlanController.paymentUrl.value !=""
                  ),
                  kHeight(10),
                  Visibility(
                    visible:subscriptionPlanController.paymentUrl.value !="",
                    child: SizedBox(
                      width: double.infinity,
                      child:   Card(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child:PaymentSummaryText(
                            amount:subscriptionPlanController.paymentUrl.value,
                            text: 'ID',
                          ),
                        ),
                      ),
                    ),
                  ),
                  kHeight(20),
                  Text(
                    "Order Summary",
                    style: theme.textTheme.titleLarge,
                  ),
                  kHeight(10),
                  SizedBox(
                    width: double.infinity,
                    child:   Card(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(planController.planId !=null?
                              planController.planCategories.where((p0) => p0.id==planController.planId).toList().isNotEmpty?
                              planController.planCategories.where((p0) => p0.id==planController.planId).toList()[0].name:
                              "":"",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text("${subscriptionPlanController.subscriptionPlan[subscriptionCardIndex].name}"),
                            Text(
                              "${subscriptionPlanController.subscriptionPlan[subscriptionCardIndex].price} KD",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  kHeight(20),
                  Column(
                    children: [
                      Card(
                        color: kWhiteColor,
                        child: Row(
                          children: [
                            kWidth(10),
                            const Text(
                              "Coupon Code",
                              style: TextStyle(fontSize: 20),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(
                                () => TextFormField(
                                  controller:
                                      subscriptionPlanController.couponController,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                      suffixIcon: couponController.isLoading.value
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.deepOrange,
                                                  borderRadius:
                                                      BorderRadius.circular(10)),
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ))
                                          : InkWell(
                                              onTap: () {
                                                couponController.verifyCoupon();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.deepOrange,
                                                    borderRadius:
                                                        BorderRadius.circular(10)),
                                                child: const Icon(
                                                  Icons.check,
                                                  color: kWhiteColor,
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(vertical: 7)),
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  kHeight(20),
                  Text(
                    "Payment Summary",
                    style: theme.textTheme.titleLarge,
                  ),
                  kHeight(10),
                  // final couponsValue = couponController.couponsList[0];

                  Obx(
                    () {
                      return Card(
                        color: kWhiteColor,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              PaymentSummaryText(
                                amount: couponController.couponsList.isEmpty
                                    ? "${subscriptionPlanController.subscriptionPlan[subscriptionCardIndex].price} KD"
                                    : "${couponController.couponsList[0].total} KD",
                                text: 'Sub Total',
                              ),
                              PaymentSummaryText(
                                amount: couponController.couponsList.isEmpty
                                    ? '0.00 KD'
                                    : "${couponController.couponsList[0].discount} KD",
                                text: 'Discount',
                              ),
                              PaymentSummaryText(
                                amount: couponController.couponsList.isEmpty
                                    ? "${subscriptionPlanController.subscriptionPlan[subscriptionCardIndex].price} KD"
                                    : "${couponController.couponsList[0].grandTotal} KD",
                                text: 'Total',
                                color: Colors.deepOrange,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),


                ],
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  final statusCode =
                  await CreateSubscriptionAPiService().createSubscription( );
                  log(statusCode.toString(), name: "statusCode");
                  if (statusCode == 400) {
                    toast("Already subscription plan exists",
                        duration: Duration(seconds: 5));
                  } else if (statusCode == 200) {
                    if (subscriptionPlanController
                        .subscriptionPlan[subscriptionCardIndex].price ==
                        0.0) {
                      Get.snackbar("Success", "Payment capture success",backgroundColor: kPrimaryColor, colorText: kWhiteColor);
                      Get.off(const OTPSuccessScreen(screenName: true))!
                          .then((value) => null);
                    } else {
                      log(subscriptionPlanController.transactionUrl.toString(),
                          name: "transaction Url name");
                      Get.to(const PaymentGatewayWebview())?.then(
                              (value) => CreateSubscriptionAPiService().checkOrderStatus());
                    }
                  }

                },
                child: Text(
                  "Checkout",
                  style: theme.textTheme.labelLarge,
                ))
          ],
        ),
      ),
    );
  }
}

class PaymentSummaryText extends StatelessWidget {
  const PaymentSummaryText(
      {super.key, required this.amount, required this.text, this.color});

  final String text;
  final String amount;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          amount,
          style: TextStyle(fontSize: 18, color: color),
        )
      ],
    );
  }
}
