import 'dart:developer';

import 'package:diet_diet_done/diet_delivery/calendar/api/get_diet_meals.dart';
import 'package:diet_diet_done/diet_delivery/calendar/api/submit_selected_meal_service.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/calendar_controller.dart';

import 'package:diet_diet_done/diet_delivery/calendar/model/diet_meals_model.dart';
import 'package:diet_diet_done/profile_config/controller/subscription_plan_controller.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';

class DietMenuController extends GetxController {
  final subscriptionPlanController = Get.find<SubscriptionPlanController>();
  final calendarController = Get.find<CalendarController>();

  final selectedMealsByCategory = <int, List<int>>{}.obs;
  final selectedMealsNameByCategory = <int, List<String>>{}.obs;

  RxList mealCategoryIdx = [].obs;
  var dietMenuLists = <DietMealsModel>[].obs;
  RxBool isLoading = false.obs;
  RxInt index = 0.obs;
  var dietMenuSelectedDate = (DateTime.now()).obs;
  RxDouble selectedCalories = 0.0.obs;

  void setSelectedDate(DateTime date) {
    dietMenuSelectedDate.value = date;
  }

  Future<void> fetchDietMeals(DateTime dateTime) async {
    try {
      final f = new DateFormat('yyyy-MM-dd');

      isLoading.value = true;
      selectedCalories.value = 0.0;
      await GetDietMealsAPiService().fetchDietMeal(f.format(dateTime)).then(
            (value) => {
             initializeDietMenu(value)
            }
          );



      update();
    } catch (e,st) {
      log("Error while fetching Diet Menu Meals: $e");
      print(st);
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
      log(selectedMealsByCategory[categoryIdx].toString(), name: "toggle meal id");
      log(mealId.toString(), name: "toggle meal id");

    } else if (selectedMealsByCategory[categoryIdx]!.length < itemCount) {
      selectedMealsByCategory[categoryIdx]!.add(mealId);
      log(selectedMealsByCategory.toString(), name: "toggle meal id else");
      log(selectedMealsByCategory[categoryIdx].toString(), name: "toggle meal id else");
      log(mealId.toString(), name: "toggle meal id else");
      log(dietMenuLists[0].meals[0].toString(), name: "toggle meal id else");
    } else {
      toast("Item count limit reached for this category");
    }
    print("calories updated 1");
    print(selectedCalories.value);
    print(mealCategoryIdx.toString());

    updateSelectedCalories();
    update();
  }
  // 7768 7727
  void updateSelectedCalories() {
    selectedCalories.value = 0.0;
    selectedMealsByCategory.forEach((categoryId, mealIds) {
      print("calories updated 3");
      print(selectedCalories.value);
      print(categoryId);
      print(mealIds);
      mealIds.forEach((mealId) {
        final meal = dietMenuLists[0]
            .meals
            .expand((category) => category.items)
            .firstWhere((item) => item.id == mealId);
        selectedCalories.value += meal.calories;
      });
    });
    print("calories updated 2");
    print(selectedCalories.value);
  }

  bool canSelectMoreMeals(int categoryIdx, int itemCount) {
    return selectedMealsByCategory[categoryIdx]!.length < itemCount;
  }

  initializeDietMenu(List<DietMealsModel> value) {
    selectedMealsByCategory.value={};
    selectedMealsNameByCategory.value={};
    dietMenuLists.value = value;
    mealCategoryIdx.value = [];
    for (int i = 0; i < dietMenuLists[0].meals.length; i++) {
      selectedMealsByCategory[i] = [];
      selectedMealsNameByCategory[i] = [];
      mealCategoryIdx.add (dietMenuLists[0].meals[i].id);

    }
    print("mealCategoryIdx");
    print(mealCategoryIdx.toString());
    selectedMealsByCategory.forEach((categoryId, mealIds) {
      print("selectedMealsByCategory data 1");
      print(categoryId);
      print(mealIds);

    });
    for(var i=0; i<dietMenuLists.length;i++){
      for(var j=0; j<dietMenuLists[i].meals.length;j++){
        if(dietMenuLists[i].meals[j].items[0].isSelected){
          print("toggleMealSelection called");
          toggleMealSelection(dietMenuLists[i].meals[j].items[0].id,
              dietMenuLists[i].meals[j].items[0].name,
              dietMenuLists[i].meals[j].itemCount,
              j);
        }
      }
    }
  }
}
