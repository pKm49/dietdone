import 'dart:developer';

import 'package:diet_diet_done/diet_delivery/home/api/get_profile_service.dart';
import 'package:diet_diet_done/diet_delivery/home/model/get_profile_model.dart';
import 'package:get/get.dart';

class GetProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<GetProfileModel> profileList = <GetProfileModel>[].obs;

  @override
  void onInit() {
    GetProfileService().fetchProfile();
    super.onInit();
  }

  fetchProfileData() async {
    try {
      isLoading = true.obs;
      await GetProfileService().fetchProfile().then((value) {
        profileList.value = value;
      });
    } catch (e) {
      log("Error fetching User Profile data $e");
    } finally {
      isLoading.value = false;
    }
  }
}
