import 'dart:developer';

import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/diet_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DietCustomMenuCard extends StatelessWidget {
  const DietCustomMenuCard({
    super.key,
    required this.size,
    required this.onTap,
    required this.index,
    required this.dietMenuController,
    required this.listIdx,
  });

  final Size size;
  final void Function()? onTap;
  final int index;
  final int listIdx;
  final DietMenuController dietMenuController;

  @override
  Widget build(BuildContext context) {
    final dietMealsData =
        dietMenuController.dietMenuLists[0].meals[listIdx].items[index];

    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 240, 240, 240),
                        borderRadius: BorderRadius.circular(15)),
                    height: size.height * 0.25,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Text(
                                  dietMealsData.name,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${dietMealsData.calories}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              const Spacer(),
                              GetBuilder<DietMenuController>(
                                builder: (controller) => Row(
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          dietMenuController
                                              .toggleMealSelection(
                                            dietMealsData.id,
                                            dietMealsData.name,
                                            dietMenuController.dietMenuLists[0]
                                                .meals[listIdx].itemCount,
                                            listIdx,
                                          );

                                          log(
                                              dietMenuController
                                                  .mealCategoryIdx.value
                                                  .toString(),
                                              name: "meal category id");
                                          log(dietMealsData.id.toString(),
                                              name: "meal id");
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 2),
                                          child: Text(
                                            controller.selectedMealsByCategory[
                                                            listIdx]
                                                        ?.contains(
                                                            dietMealsData.id) ??
                                                    false
                                                ? "Remove"
                                                : "Add",
                                            style:
                                                TextStyle(color: kWhiteColor),
                                          ),
                                        )),
                                  ],
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
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: Image.network(dietMealsData.image).image,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
