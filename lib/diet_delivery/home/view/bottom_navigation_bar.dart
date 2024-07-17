import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/diet_delivery/calendar/view/calender_screen.dart';
import 'package:diet_diet_done/diet_delivery/home/controller/bottom_nav_controller.dart';
import 'package:diet_diet_done/diet_delivery/home/view/home_screen.dart';
import 'package:diet_diet_done/food_delivery/cart/view/cart_screen.dart';
import 'package:diet_diet_done/food_delivery/menu/api/show_menu_api_service.dart';
import 'package:diet_diet_done/food_delivery/menu/controller/Menu_controller.dart';
import 'package:diet_diet_done/food_delivery/menu/view/menu_scree.dart';
import 'package:diet_diet_done/profile/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final menuController = Get.find<MenusController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ShowMenuApiService().showMenu();
      menuController.fetchMeals();
    });
    return Scaffold(
        body: menuController.showMenu != false
            ? Stack(
                children: [
                  GetBuilder<BottomNavController>(
                    builder: (controller) => controller.currentScreen,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: kWhiteColor,
                      height: size.height * 0.07,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const BottomNavButton(
                            icon: 'assets/icon/Home.svg',
                            idx: 1,
                            screen: HomeScreen(),
                          ),
                          const BottomNavButton(
                            icon: 'assets/icon/Calender.svg',
                            idx: 2,
                            screen: CalenderScreen(),
                          ),
                          kWidth(35),
                          const BottomNavButton(
                            icon: 'assets/icon/Cart.svg',
                            idx: 3,
                            screen: CartScreen(),
                          ),
                          const BottomNavButton(
                            icon: 'assets/icon/user.svg',
                            idx: 4,
                            screen: ProfileScreen(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GetBuilder<BottomNavController>(
                      builder: (controller) => CircleAvatar(
                        radius: 45,
                        backgroundColor: kWhiteColor,
                        child: controller.currentTab != 5
                            ? CircleAvatar(
                                radius: 30,
                                backgroundColor: kPrimaryColor,
                                child: InkWell(
                                  onTap: () {
                                    controller.updateScreen(MenuScreen(), 5);
                                  },
                                  child: SvgPicture.asset(
                                    height: 40,
                                    "assets/icon/Menu.svg",
                                  ),
                                ),
                              )
                            : SvgPicture.asset(
                                height: 40,
                                "assets/icon/Menu.svg",
                                color: kPrimaryColor,
                              ),
                      ),
                    ),
                  )
                ],
              )
            : Stack(
                children: [
                  GetBuilder<BottomNavController>(
                    builder: (controller) => controller.currentScreen,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: kWhiteColor,
                      height: size.height * 0.07,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const BottomNavButton(
                            icon: 'assets/icon/Home.svg',
                            idx: 1,
                            screen: HomeScreen(),
                          ),
                          const BottomNavButton(
                            icon: 'assets/icon/Calender.svg',
                            idx: 2,
                            screen: CalenderScreen(),
                          ),
                          const BottomNavButton(
                            icon: 'assets/icon/user.svg',
                            idx: 4,
                            screen: ProfileScreen(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
  }
}

class BottomNavButton extends StatelessWidget {
  const BottomNavButton({
    super.key,
    required this.icon,
    required this.idx,
    required this.screen,
  });

  final String icon;
  final int idx;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      builder: (controller) => InkWell(
        onTap: () {
          controller.updateScreen(screen, idx);
        },
        child: controller.currentTab == idx
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    icon,
                    color: kPrimaryColor,
                  ),
                  kHeight(5),
                  Container(
                    height: 2,
                    width: 15,
                    color: kPrimaryColor,
                  )
                ],
              )
            : SvgPicture.asset(
                icon,
              ),
      ),
    );
  }
}
