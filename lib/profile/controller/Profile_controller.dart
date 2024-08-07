import 'dart:developer';
import 'package:diet_diet_done/profile/api/get_ingredients.dart';
import 'package:diet_diet_done/profile/api/get_subscription_hostory.dart';
import 'package:diet_diet_done/profile/model/allergies_model.dart';
import 'package:diet_diet_done/profile/model/subscription_history_model.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isShowSearch = false.obs;
  RxList<AllergiesModel> selectedOptions = <AllergiesModel>[].obs;
  RxList<AllergiesModel> allergiesList = <AllergiesModel>[].obs;
  final List<int> selectedOptionIds = [];
  Map referralData = {};
  RxList<SubscriptionHistoryModel> subsHistoryList =
      <SubscriptionHistoryModel>[].obs;
  RxBool isLoading = false.obs;

  void toggleOption(AllergiesModel option) {
    if ( selectedOptions.where((element) => element.id==option.id).toList().isNotEmpty ) {
      selectedOptions.removeWhere((element) => element.id==option.id);
    } else {
      selectedOptions.add(option);
    }
  }

  Future<void> fetchIngredient() async {
    try {
      await GetIngredientApiServices()
          .fetchIngredient()
          .then((ingredient) => allergiesList.value = ingredient);
    } catch (e) {
      log("Error while fetching ingredients: $e");
    }
  }

  List<int> submitSelectedOptions() {
    return selectedOptions.map((option) => option.id).toList();
  }

  Future<void> fetchSubsHistory() async {
    try {
      isLoading.value = true;
      final subs =
          await GetSubscriptionHistoryApiService().getSubscriptionHistory();
      subsHistoryList.value = subs;
      log(subsHistoryList.toString(), name: "Subs History..");
    } catch (e) {
      log("Error while fetching subscription history: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
