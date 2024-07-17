import 'dart:developer';

import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/profile_config/controller/profile_config_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class GenderSelectingWidget extends StatelessWidget {
  const GenderSelectingWidget({
    super.key,
    required this.size,
    required this.theme,
  });

  final Size size;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final profileConfigController = Get.find<ProfileConfigController>();
    final signUpController = Get.find<SignUpController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            profileConfigController.isGenderSelected = false;
            signUpController.gender = "male";
            profileConfigController.update();
          },
          child: Container(
            height: size.height * 0.05,
            width: size.width * 0.36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: profileConfigController.isGenderSelected
                  ? Colors.grey[300]
                  : kBlackColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icon/Male.svg"),
                Text(
                  "Male",
                  style: theme.textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            profileConfigController.isGenderSelected = true;
            signUpController.gender = "Female";
            profileConfigController.update();
          },
          child: Container(
            height: size.height * 0.05,
            width: size.width * 0.36,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: profileConfigController.isGenderSelected
                    ? kBlackColor
                    : Colors.grey[300]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icon/female.svg",
                  color: profileConfigController.isGenderSelected
                      ? kWhiteColor
                      : kBlackColor,
                ),
                Text(
                  "Female",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: profileConfigController.isGenderSelected
                        ? kWhiteColor
                        : kBlackColor,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
