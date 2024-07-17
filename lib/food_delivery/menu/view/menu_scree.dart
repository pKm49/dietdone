import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/calendar_controller.dart';
import 'package:diet_diet_done/food_delivery/menu/api/show_menu_api_service.dart';
import 'package:diet_diet_done/food_delivery/menu/controller/Menu_controller.dart';
import 'package:diet_diet_done/food_delivery/menu/model/meals_model.dart';
import 'package:diet_diet_done/food_delivery/menu/view/product_screen.dart';
import 'package:diet_diet_done/food_delivery/menu/widget/custom_menu_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});

  final List imageList = [
    "assets/temp_images/images (2).jpeg",
    "assets/temp_images/images (1).jpeg",
    "assets/temp_images/images (2).jpeg",
    "assets/temp_images/images (1).jpeg",
  ];

  final List name = [
    "Pancake",
    "Snacks",
    "Beverages",
    "Drinks",
    "Salad",
    "Coffee"
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final calendarController = Get.find<CalendarController>();
    final menuController = Get.find<MenusController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ShowMenuApiService().showMenu();

      menuController.fetchMeals();
    });
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: kWhiteColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Menu"),
        actions: [
          InkWell(
            child: SvgPicture.asset(
              "assets/icon/Search.svg",
              height: 25,
            ),
          ),
          kWidth(10),
          InkWell(
            child: SvgPicture.asset(
              "assets/icon/Notification.svg",
              height: 25,
            ),
          ),
          kWidth(15),
        ],
      ),
      body: Obx(
        () => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kHeight(5),
                  TabBar(theme: theme),
                  kHeight(15),
                  const Text(
                    "Special offers",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  SizedBox(
                      height: size.height * 0.19,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => kWidth(10),
                        scrollDirection: Axis.horizontal,
                        itemCount: imageList.length,
                        itemBuilder: (context, index) => Card(
                          child: SizedBox(
                            width: size.width * 0.32,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                    child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(
                                    image: AssetImage(imageList[index]),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    kHeight(100),
                                    kWidth(500),
                                    const Text(
                                      "Pancakes",
                                      style: TextStyle(
                                          color: kWhiteColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                  kHeight(20),
                  SizedBox(
                    height: 30,
                    child: ListView.builder(
                      itemCount: name.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GetBuilder<MenusController>(
                                builder: (controller) => InkWell(
                                  onTap: () {
                                    controller.selectMenu(index);
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        name[index],
                                        style: TextStyle(
                                          color:
                                              controller.selectedIndex == index
                                                  ? Colors.pink
                                                  : Colors.grey,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Container(
                                        height: 2,
                                        width: 30,
                                        color: controller.selectedIndex == index
                                            ? Colors.pink
                                            : Colors.transparent,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 40),
                        ],
                      ),
                    ),
                  ),
                  kHeight(15),
                  const Text(
                    "Monday BreakFast",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  kHeight(10),
                  Expanded(
                      child: menuController.mealsList.isEmpty
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : GridView.builder(
                              itemCount: menuController.mealsList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 20,
                                      mainAxisExtent: size.height * 0.3),
                              itemBuilder: (context, index) {
                                final mealsList =
                                    menuController.mealsList[index];
                                return CustomMenuCard(
                                  size: size,
                                  onTap: () {
                                    Get.to(ProductPage(
                                      mealsId: mealsList.id.toString(),
                                      menuController: menuController,
                                    ));
                                  },
                                  mealsModel: mealsList,
                                  calendarController: calendarController,
                                );
                              },
                            )),
                ],
              ),
            ),
            menuController.showMenu.value
                ? SizedBox()
                : Container(
                    width: double.infinity,
                    color: kWhiteColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fastfood_sharp,
                          size: 80,
                        ),
                        kHeight(10),
                        Text(
                          "Currently Test Delivery\nfeature is not available...!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class TabBar extends StatelessWidget {
  const TabBar({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenusController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              controller.tabBarIdx = 0;
              controller.voidChangeTabBar(0);
            },
            child: Container(
              height: 38,
              width: 111,
              decoration: BoxDecoration(
                  color:
                      controller.tabBarIdx == 0 ? kPrimaryColor : kWhiteColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text("Break Fast",
                      style: controller.tabBarIdx == 0
                          ? theme.textTheme.labelLarge
                          : TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold))),
            ),
          ),
          kWidth(5),
          InkWell(
            onTap: () {
              controller.tabBarIdx = 1;
              controller.voidChangeTabBar(1);
            },
            child: Container(
              height: 38,
              width: 111,
              decoration: BoxDecoration(
                  color:
                      controller.tabBarIdx == 1 ? kPrimaryColor : kWhiteColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text("Break Fast",
                      style: controller.tabBarIdx == 1
                          ? theme.textTheme.labelLarge
                          : TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold))),
            ),
          ),
          kWidth(5),
          InkWell(
            onTap: () {
              controller.tabBarIdx = 2;
              controller.voidChangeTabBar(2);
            },
            child: Container(
              height: 38,
              width: 111,
              decoration: BoxDecoration(
                  color:
                      controller.tabBarIdx == 2 ? kPrimaryColor : kWhiteColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text("Dinner",
                      style: controller.tabBarIdx == 2
                          ? theme.textTheme.labelLarge
                          : TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold))),
            ),
          ),
        ],
      ),
    );
  }
}
