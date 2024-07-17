import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/profile_config/controller/plan_categories_controller.dart';
import 'package:diet_diet_done/profile_config/view/subscription_screen.dart';
import 'package:diet_diet_done/widget/carousal_slider.dart';
import 'package:diet_diet_done/auth/sign_up/widget/custom_app_bar.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

class PlanSelectionScreen extends StatelessWidget {
  const PlanSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final planController = Get.find<PlanCategoriesController>();
      planController.fetchPlanCategories();
    });
    final planController = Get.find<PlanCategoriesController>();
    final theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        onTapBackButton: () {
          Get.back();
        },
        onTapIconButton: () {},
        iconColor: kPrimaryColor,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          kHeight(10),
          Text(
            "Which plan you need?",
            style: theme.textTheme.titleMedium,
          ),
          kHeight(size.height * 0.15),
          CarousalPlanSlider(
            size: size,
            planController: planController,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: ElevatedButton(
                onPressed: () {
                  if (planController.planCategories.isEmpty) {
                    toast("Loading...");
                  } else {
                    Get.to(SubscriptionSCreen());
                  }
                },
                child: Text(
                  "Done",
                  style: theme.textTheme.labelLarge,
                )),
          )
        ],
      ),
    );
  }
}
