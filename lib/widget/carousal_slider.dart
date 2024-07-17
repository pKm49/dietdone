import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/profile_config/controller/plan_categories_controller.dart';
import 'package:diet_diet_done/profile_config/view/subscription_screen.dart';
import 'package:diet_diet_done/widget/blur_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CarousalPlanSlider extends StatelessWidget {
  CarousalPlanSlider({
    Key? key,
    required this.size,
    required this.planController,
  }) : super(key: key);

  final Size size;
  final PlanCategoriesController planController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => planController.isLoading.value
          ? CircularProgressIndicator()
          : CarouselSlider.builder(
              itemCount: planController.planCategories.length,
              options: CarouselOptions(
                enlargeCenterPage: true,
                viewportFraction: 0.60,
                height: size.height * 0.40,
                enableInfiniteScroll: false,
              ),
              itemBuilder: (context, index, realIndex) {
                planController.planId =
                    planController.planCategories[realIndex].id;
                log(planController.planId.toString());
                final categories = planController.planCategories[index];
                return InkWell(
                  onTap: () {
                    planController.planId = categories.id;
                    log(planController.planId.toString(), name: "Plan Id...");
                    Get.to(SubscriptionSCreen());
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                  child: ClipRRect(
                                child: Image.network(
                                  categories.image,
                                  fit: BoxFit.cover,
                                ),
                              )),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomBlurCard(
                        index: index,
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              categories.mealConfiguration.length,
                              (mealIndex) => Text(
                                categories.mealConfiguration[mealIndex],
                                style: TextStyle(
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
