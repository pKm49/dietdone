import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/food_delivery/menu/controller/Menu_controller.dart';
import 'package:diet_diet_done/food_delivery/menu/widget/carousal_menu_image.dart';
import 'package:diet_diet_done/food_delivery/menu/widget/ingredient_widget.dart';
import 'package:diet_diet_done/food_delivery/menu/widget/menu_bottom_nav_bar.dart';
import 'package:diet_diet_done/food_delivery/menu/widget/price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key, required this.menuController, required this.mealsId});
  MenusController? menuController;
  String mealsId;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.find<MenusController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fetchMealById(mealsId);
    });
    final theme = Theme.of(context);
    final mealsList = menuController!.mealsIdList[0];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kLightPrimaryColor,
        automaticallyImplyLeading: true,
      ),
      bottomNavigationBar: MenuBottomNavBar(theme: theme),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarousalMenuImage(
                size: size, mealsList: mealsList, controller: controller),
            kHeight(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mealsList.name,
                    style: theme.textTheme.titleMedium,
                  ),
                  kHeight(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icon/Calories.svg",
                                    height: 20,
                                  ),
                                  kWidth(5),
                                  Text("${mealsList.calories}"),
                                ],
                              ),
                              kWidth(10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  kWidth(5),
                                  Text("${mealsList.rating}")
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const FaIcon(FontAwesomeIcons.heart))
                    ],
                  ),
                  kHeight(20),
                  PriceWidget(mealsList: mealsList, theme: theme),
                  kHeight(20),
                  IngredientWidget(),
                  kHeight(20),
                  const Text("Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  kHeight(5),
                  Text(mealsList.description == ""
                      ? "There is no description.."
                      : mealsList.description)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
