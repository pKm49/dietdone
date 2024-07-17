import 'dart:developer';

import 'package:diet_diet_done/food_delivery/menu/api/get_meals_api_service.dart';
import 'package:diet_diet_done/food_delivery/menu/model/meals_by_id_model.dart';
import 'package:diet_diet_done/food_delivery/menu/model/meals_model.dart';
import 'package:get/get.dart';

class MenusController extends GetxController {
  double? productImageIndex = 0.0;
  int tabBarIdx = 0;
  RxBool isLoading = false.obs;
  RxList<MealsModel> mealsList = <MealsModel>[].obs;

  RxList<MealsByIdModel> mealsIdList = <MealsByIdModel>[].obs;
  RxBool showMenu = false.obs;
  void updateIndex(idx) {
    productImageIndex = idx;
    update();
  }

  voidChangeTabBar(int value) {
    tabBarIdx = value;
    update();
  }

  RxInt selectedIndex = 0.obs;

  void selectMenu(int index) {
    selectedIndex.value = index;
    update();
  }

  fetchMeals() {
    try {
      isLoading.value = true;
      GetMealsAPiService().fetchMeal().then((meals) => mealsList.value = meals);
    } catch (e) {
      isLoading.value = false;
      log("Error while fetching meals $e");
    } finally {
      isLoading.value = false;
    }
  }

  fetchMealById(String mealsId) {
    try {
      isLoading.value = true;
      GetMealsAPiService()
          .fetchModelById(mealsId)
          .then((mealsId) => mealsIdList.value = mealsId);
    } catch (e) {
      isLoading.value = false;

      log("Failed to fetch mealsById: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
