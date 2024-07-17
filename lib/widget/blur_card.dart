import 'dart:ui';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/profile_config/controller/plan_categories_controller.dart';
import 'package:diet_diet_done/profile_config/view/subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBlurCard extends StatelessWidget {
  const CustomBlurCard({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final planController = Get.find<PlanCategoriesController>();
    final plans = planController.planCategories[index];
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white.withOpacity(0.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: EdgeInsets.all(7),
              color: Colors.white.withOpacity(0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              plans.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                color: kWhiteColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            plans.description,
                            style: TextStyle(
                              fontSize: 12,
                              color: kWhiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_circle_right,
                      color: kWhiteColor,
                      size: 35,
                    )
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
