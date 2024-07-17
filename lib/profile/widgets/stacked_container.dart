import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/diet_delivery/home/controller/getProfileController.dart';
import 'package:diet_diet_done/profile/controller/Profile_controller.dart';
import 'package:diet_diet_done/profile/widgets/custom_list_tile_cards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StackedContainer extends StatelessWidget {
  const StackedContainer(
      {super.key, required this.size, required this.profileController});

  final Size size;
  final GetProfileController profileController;
  @override
  Widget build(BuildContext context) {
    final referralProfileController = Get.find<ProfileController>();
    return Positioned(
      bottom: 0,
      child: Container(
        height: size.height - 150,
        width: size.width,
        decoration: const BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: ListView(
          children: [
            Obx(
              () => Column(
                children: [
                  kHeight(size.height * 0.08),
                  profileController.profileList.isEmpty
                      ? Text(
                          "Loading...",
                        )
                      : Text(profileController.profileList[0].firstName),
                  kHeight(10),
                  profileController.profileList[0].email.isEmpty
                      ? SizedBox()
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: kLightPrimaryColor),
                          child: Text(profileController.profileList[0].email),
                        ),
                  kHeight(10),
                  CustomListTileCards(
                    profileController: profileController,
                    refferalProfileController: referralProfileController,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
