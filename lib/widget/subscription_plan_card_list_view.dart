import 'dart:developer';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/profile_config/controller/subscription_plan_controller.dart';
import 'package:diet_diet_done/profile_config/model/get_subscription_plan_model.dart';
import 'package:diet_diet_done/widget/subscription_shimmer_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionPlanCardListView extends StatelessWidget {
  const SubscriptionPlanCardListView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SubscriptionPlanController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => controller
                .isLoading.value // Assuming isLoading is a boolean Rx variable
            ? SubscriptionShimmerLoader()
            : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.subscriptionPlan.length,
                itemBuilder: (context, index) {
                  final subscription = controller.subscriptionPlan[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SubscriptionCard(
                      controller: controller,
                      subscription: subscription,
                      subscriptionCardIndex: index,
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  SubscriptionCard(
      {super.key,
      required this.controller,
      required this.subscription,
      required this.subscriptionCardIndex});

  final SubscriptionPlanController controller;
  final GetSubscriptionPlanModel subscription;
  int subscriptionCardIndex;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.subscriptionCardIdx.value = subscriptionCardIndex;
        controller.subscriptionId.value =
            controller.subscriptionPlan[subscriptionCardIndex].id;
        log(controller.subscriptionId.value.toString());
      },
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: subscription.id == controller.subscriptionId.value
                      ? kPrimaryColor
                      : Colors.transparent,
                  width: 2.5)),
          child: Card(
            color: kBlackColor,
            child: SizedBox(
              height: 180,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          subscription.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kWhiteColor,
                              fontSize: 15),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            controller.subscriptionPlan.length,
                            (index) {
                              // final mealList =
                              //     subscription.mealConfiguration[index];
                              return Text(
                                "",
                                style:
                                    TextStyle(color: kWhiteColor, fontSize: 11),
                                textAlign: TextAlign.start,
                              );
                            },
                          ),
                        ),
                        kHeight(5),
                        RichText(
                            text: TextSpan(
                          children: [
                            TextSpan(
                                text: "${subscription.protein}",
                                style: TextStyle(
                                    fontSize: 11, fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: " protein  ",
                                style: TextStyle(
                                    fontSize: 11, fontWeight: FontWeight.w300)),
                            TextSpan(
                                text: "${subscription.carbohydrates}",
                                style: TextStyle(
                                    fontSize: 11, fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: " Carbon",
                                style: TextStyle(
                                    fontSize: 11, fontWeight: FontWeight.w300))
                          ],
                        )),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${subscription.strikePrice}',
                          style: TextStyle(
                              fontSize: 20,
                              color: kWhiteColor,
                              fontWeight: FontWeight.bold,
                              decorationColor: kWhiteColor,
                              decorationThickness: 3,
                              decoration: TextDecoration.lineThrough),
                        ),
                        Row(
                          children: [
                            Text(
                              "${subscription.price}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kWhiteColor,
                                  fontSize: 32),
                            ),
                            kWidth(5),
                            const RotatedBox(
                                quarterTurns: 45,
                                child: Text(
                                  "KWD",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: kWhiteColor,
                                  ),
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              subscription.durationType,
                              style:
                                  TextStyle(color: kWhiteColor, fontSize: 11),
                            ),
                            kWidth(4),
                            Container(
                              height: 20,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [Color(0xFFF46A6A), kPrimaryColor],
                                    tileMode: TileMode.clamp),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  kWidth(10),
                                  const Text(
                                    "Best Value",
                                    style: TextStyle(
                                        color: kWhiteColor, fontSize: 10),
                                  ),
                                  kWidth(10),
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [Color(0xFFF46A6A), kPrimaryColor],
                                  tileMode: TileMode.clamp),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              kWidth(10),
                              const Text(
                                "Seasonal Offers",
                                style:
                                    TextStyle(color: kWhiteColor, fontSize: 10),
                              ),
                              kWidth(10),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
