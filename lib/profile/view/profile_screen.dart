import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/diet_delivery/home/controller/getProfileController.dart';
import 'package:diet_diet_done/profile/api/Get_referral_code.dart';
import 'package:diet_diet_done/profile/api/update_allergies.dart';
import 'package:diet_diet_done/profile/controller/Profile_controller.dart';

import 'package:diet_diet_done/profile/widgets/profile_image.dart';
import 'package:diet_diet_done/profile/widgets/stacked_container.dart';
import 'package:diet_diet_done/profile_config/controller/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final getProfileController = Get.find<GetProfileController>();
    final profileController = Get.find<ProfileController>();
    final addressController = Get.find<AddressController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      addressController.fetchAddress();
      final profileController = Get.find<ProfileController>();
      await profileController.fetchSubsHistory();
      profileController.referralData =
          await GetReferralCodeApiServcie().getReferralCode();
      UpdateAllergiesAPiServices().getUpdatedAllergies();
    });
    getProfileController.fetchProfileData();
    profileController.fetchIngredient();
    final size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    return Scaffold(
      backgroundColor: kLightPrimaryColor,
      body: getProfileController.profileList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                StackedContainer(
                  size: size,
                  profileController: getProfileController,
                ),
                ProfileImage(
                  size: size,
                ),
              ],
            ),
    );
  }
}
