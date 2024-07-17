import 'dart:developer';

import 'package:diet_diet_done/profile_config/api_service/get_plan_services.dart';
import 'package:diet_diet_done/profile_config/model/get_plan_categories_model.dart';
import 'package:get/get.dart';

class PlanCategoriesController extends GetxController {
  RxList<GetPlanCategoriesModel> planCategories =
      <GetPlanCategoriesModel>[].obs;
  RxBool isLoading = false.obs;
  int? planId;
  @override
  void onInit() {
    GetPlanCategoriesAPiServices().fetchPlanCategories();
    super.onInit();
  }

  void fetchPlanCategories() async {
    try {
      isLoading.value = true;
      await GetPlanCategoriesAPiServices()
          .fetchPlanCategories()
          .then((value) => planCategories = value.obs);

      log(planCategories.toString(), name: "plan controller");
    } catch (e) {
      isLoading = false.obs;
      log("Error fetching plan categories $e");
    } finally {
      isLoading.value = false;
    }
  }
}
