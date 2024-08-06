import 'dart:developer';

import 'package:diet_diet_done/diet_delivery/calendar/api/get_diet_meals.dart';
import 'package:diet_diet_done/diet_delivery/calendar/api/submit_selected_meal_service.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/calendar_controller.dart';

import 'package:diet_diet_done/diet_delivery/calendar/model/diet_meals_model.dart';
import 'package:diet_diet_done/profile_config/controller/subscription_plan_controller.dart';

import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

class DietMenuController extends GetxController {
  final subscriptionPlanController = Get.find<SubscriptionPlanController>();
  final calendarController = Get.find<CalendarController>();

  final selectedMealsByCategory = <int, List<int>>{}.obs;
  final selectedMealsNameByCategory = <int, List<String>>{}.obs;

  RxList mealCategoryIdx = [].obs;
  List<DietMealsModel> dietMenuLists = [];
  RxBool isLoading = false.obs;
  RxInt index = 0.obs;
  DateTime dietMenuSelectedDate = DateTime.now();
  RxDouble selectedCalories = 0.0.obs;

  void setSelectedDate(DateTime date) {
    dietMenuSelectedDate = date;
  }

  Future<void> fetchDietMeals() async {
    try {
      isLoading.value = true;
      await GetDietMealsAPiService().fetchDietMeal().then(
            (value) => dietMenuLists = value,
          );

      for (int i = 0; i < dietMenuLists[0].meals.length; i++) {
        selectedMealsByCategory[i] = [];
        selectedMealsNameByCategory[i] = [];
      }

      update();
    } catch (e) {
      log("Error while fetching Diet Menu Meals: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitSelectMeals() async {
    try {
      toast("submitSelectMeals triggered");
      log(selectedMealsByCategory.toString(), name: "selectedMealsByCategory");
      final selectedMealsIdx =
          selectedMealsByCategory.values.expand((list) => list).toList();

      log(selectedMealsIdx.toString(), name: "selected meal idx");
      log(
          subscriptionPlanController.subscriptionDetails[0].subscriptionId
              .toString(),
          name: "subscription idx");

      await SubmitSelectedMealApiService().submitSelectedMeal(
        subscriptionPlanController.subscriptionDetails[0].subscriptionId,
        mealCategoryIdx,
        selectedMealsByCategory.values.toList(),
        dietMenuSelectedDate,
      );
    } catch (e, stack) {
      toast(e.toString());
      toast(stack.toString());
      throw Exception("Error while submitting selected meal $e");
    }
  }

  void toggleMealSelection(
      int mealId, String mealName, int itemCount, int categoryIdx) {
    selectedMealsByCategory.putIfAbsent(categoryIdx, () => []);
    if (selectedMealsByCategory[categoryIdx]!.contains(mealId)) {
      selectedMealsByCategory[categoryIdx]!.remove(mealId);
      log(selectedMealsByCategory.toString(), name: "toggle meal id");

      mealCategoryIdx.remove(dietMenuLists[0].meals[categoryIdx].id);
    } else if (selectedMealsByCategory[categoryIdx]!.length < itemCount) {
      selectedMealsByCategory[categoryIdx]!.add(mealId);
      log(selectedMealsByCategory.toString(), name: "toggle meal id");
      mealCategoryIdx.add(dietMenuLists[0].meals[categoryIdx].id);
    } else {
      toast("Item count limit reached for this category");
    }
    updateSelectedCalories();
    update();
  }

  void updateSelectedCalories() {
    selectedCalories.value = 0.0;
    selectedMealsByCategory.forEach((categoryId, mealIds) {
      mealIds.forEach((mealId) {
        final meal = dietMenuLists[0]
            .meals
            .expand((category) => category.items)
            .firstWhere((item) => item.id == mealId);
        selectedCalories.value += meal.calories;
      });
    });
  }

  bool canSelectMoreMeals(int categoryIdx, int itemCount) {
    return selectedMealsByCategory[categoryIdx]!.length < itemCount;
  }
}
