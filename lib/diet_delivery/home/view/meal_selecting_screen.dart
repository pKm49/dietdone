import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/diet_delivery/home/controller/bottom_nav_controller.dart';
import 'package:diet_diet_done/diet_delivery/home/view/bottom_navigation_bar.dart';
import 'package:diet_diet_done/food_delivery/menu/view/menu_scree.dart';
import 'package:diet_diet_done/profile_config/view/plan_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MealSelectionScreen extends StatelessWidget {
  const MealSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BottomNavController>();
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
              child: Image.asset(
            "assets/background_image/d624f270bc45b08c88f64e84a7d7d980.jpg",
            fit: BoxFit.cover,
          )),
          SizedBox(
            height: size.height,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  kHeight(50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Get.to(const BottomNavBar());
                          },
                          child: const Text(
                            "Skip",
                            style: TextStyle(color: kWhiteColor),
                          )),
                    ],
                  ),
                  kHeight(size.height * 0.1),
                  const Text(
                    "Find Your Tasty Meal\nCollection",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: kWhiteColor),
                  ),
                  kHeight(20),
                  const Text(
                    "we carefully choose the finest cuts of grilled chicken, succulent beef, or perhaps tender slices of smoked turkey, ensuring they're cooked to perfection with just the right blend of",
                    style: TextStyle(color: kWhiteColor),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async {
                          controller.currentScreen = MenuScreen();
                          controller.currentTab = 5;
                          await Get.to(const BottomNavBar());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(30)),
                          width: size.width * 0.3,
                          height: 55,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/icon/Menu2.svg"),
                              const Text(
                                "Browse Meal",
                                style: TextStyle(
                                    fontSize: 11, color: kPrimaryColor),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Get.to(const PlanSelectionScreen()),
                        child: Container(
                          decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(30)),
                          width: size.width * 0.3,
                          height: 55,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/icon/Subscription.svg"),
                              const Text(
                                "Subscription",
                                style: TextStyle(
                                    fontSize: 11, color: kPrimaryColor),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
