import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/diet_menu_controller.dart';
import 'package:diet_diet_done/diet_delivery/calendar/view/calender_freeze_screen.dart';
import 'package:diet_diet_done/diet_delivery/calendar/widgets/diet_custom_menu_card_.dart';
import 'package:diet_diet_done/diet_delivery/calendar/widgets/week_calendar_widget.dart';
import 'package:diet_diet_done/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealSelectionScreen2 extends StatelessWidget {
  const MealSelectionScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final dietMenuController = Get.find<DietMenuController>();
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dietMenuController.fetchDietMeals();
    });
    return Scaffold(
      bottomNavigationBar: MealSelectionBottomContainer(
        size: size,
        theme: theme,
        calories:
            dietMenuController.dietMenuLists[0].subscriptionRecommendedCalories,
        dietMenuController: dietMenuController,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 10),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppBarBackButton(),
                    kWidth(1),
                    Text(
                      "Select Meal",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextButton.icon(
                        onPressed: () async {
                          await Get.to(CalendarFreezeScreen());
                        },
                        icon: Icon(Icons.pause_circle_outline,
                            color: kPrimaryColor),
                        label: Text(
                          "Pause",
                          style: TextStyle(color: kPrimaryColor),
                        ))
                  ],
                ),
              ),
              WeekBasedCalendar(),
              GetBuilder<DietMenuController>(
                builder: (controller) => dietMenuController
                        .dietMenuLists[0].meals.isEmpty
                    ? Center(
                        child: Column(
                        children: [
                          Icon(
                            Icons.food_bank_outlined,
                            size: 30,
                          ),
                          Text(
                            "There is no meals found!...",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ))
                    : controller.dietMenuLists.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: dietMenuController
                                  .dietMenuLists[0].meals.length,
                              itemBuilder: (context, listIdx) {
                                return Column(
                                  children: [
                                    MealNameAndItemCountWidget(
                                      size: size,
                                      dietMenuController: dietMenuController,
                                      theme: theme,
                                      name: controller
                                          .dietMenuLists[0].meals[listIdx].name,
                                      itemCount: controller.dietMenuLists[0]
                                          .meals[listIdx].itemCount,
                                      categoryIdx:
                                          listIdx, // Pass category index
                                    ),
                                    kHeight(10),
                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: dietMenuController
                                          .dietMenuLists[0]
                                          .meals[listIdx]
                                          .items
                                          .length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 20,
                                              mainAxisExtent:
                                                  size.height * 0.3),
                                      itemBuilder: (context, index) {
                                        return DietCustomMenuCard(
                                          listIdx: listIdx,
                                          index: index,
                                          size: size,
                                          dietMenuController:
                                              dietMenuController,
                                          onTap: () {
                                            final mealId = dietMenuController
                                                .dietMenuLists[0]
                                                .meals[listIdx]
                                                .items[index]
                                                .id;

                                            final mealName = dietMenuController
                                                .dietMenuLists[0]
                                                .meals[listIdx]
                                                .items[index]
                                                .name;
                                            final itemCount = dietMenuController
                                                .dietMenuLists[0]
                                                .meals[listIdx]
                                                .itemCount;
                                            dietMenuController
                                                .toggleMealSelection(
                                                    mealId,
                                                    mealName,
                                                    itemCount,
                                                    mealId);
                                          },
                                        );
                                      },
                                    ),
                                    kHeight(25)
                                  ],
                                );
                              },
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MealNameAndItemCountWidget extends StatelessWidget {
  const MealNameAndItemCountWidget({
    super.key,
    required this.size,
    required this.dietMenuController,
    required this.theme,
    required this.name,
    required this.itemCount,
    required this.categoryIdx,
  });

  final Size size;
  final DietMenuController dietMenuController;
  final ThemeData theme;
  final String name;
  final int itemCount;
  final int categoryIdx;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            SizedBox(
              width: size.width * 0.25,
              child: Divider(
                thickness: 2,
                color: kBlackColor,
              ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: kPrimaryColor, borderRadius: BorderRadius.circular(20)),
          child: Obx(
            () => Text(
              "${dietMenuController.selectedMealsByCategory[categoryIdx]!.length} / $itemCount item",
              style: theme.textTheme.labelLarge,
            ),
          ),
        )
      ],
    );
  }
}

class MealSelectionBottomContainer extends StatelessWidget {
  const MealSelectionBottomContainer({
    super.key,
    required this.size,
    required this.theme,
    required this.calories,
    required this.dietMenuController,
  });

  final Size size;
  final ThemeData theme;
  final double calories;
  final DietMenuController dietMenuController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.07,
      child: Row(
        children: [
          kWidth(20),
          Obx(() {
            final selectedCalories = dietMenuController.selectedCalories.value;
            final percentage =
                (selectedCalories / calories * 100).toStringAsFixed(1);

            return CircleAvatar(
              radius: 20,
              backgroundColor: kPrimaryColor,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: kWhiteColor,
                child: Text(
                  "$percentage%",
                  style: TextStyle(color: kPrimaryColor, fontSize: 8),
                ),
              ),
            );
          }),
          kWidth(10),
          Obx(() {
            final selectedCalories = dietMenuController.selectedCalories.value;
            return Text(
              "$selectedCalories Cal",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            );
          }),
          Spacer(),
          ElevatedButton(
            onPressed: () async {
              await dietMenuController.submitSelectMeals();
            },
            child: Text(
              "Done",
              style: theme.textTheme.labelLarge,
            ),
            style: ElevatedButton.styleFrom(
              maximumSize: Size(150, 45),
            ),
          ),
          kWidth(20),
        ],
      ),
    );
  }
}
