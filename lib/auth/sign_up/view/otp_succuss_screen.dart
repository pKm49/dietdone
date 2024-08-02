import 'dart:developer';

import 'package:diet_diet_done/auth/sign_up/controller/area_&_block_controller.dart';
import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/diet_delivery/home/view/bottom_navigation_bar.dart';
import 'package:diet_diet_done/profile_config/api_service/active_subscription.dart';
import 'package:diet_diet_done/profile_config/controller/profile_config_controller.dart';
import 'package:diet_diet_done/profile_config/view/address_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constraints/constraints.dart';
import '../../../widget/custom_button.dart';

class OTPSuccessScreen extends StatelessWidget {
  const OTPSuccessScreen({super.key, required this.screenName});

  final bool screenName;

  @override
  Widget build(BuildContext context) {
    late final areaBlockController = AreaAndBlockController();
    final profileConfigController = Get.find<ProfileConfigController>();
    final signUpController = Get.find<SignUpController>();

    final Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            kHeight(110),
            SizedBox(
              height: size.height * 0.10,
              width: size.height * 0.10,
              child: Image.asset(
                "assets/illustrations/Successmark.png",
              ),
            ),
            kHeight(48),
            Text(
              screenName ? "Subscription Successful!" : "OTP Verified",
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            kHeight(12),
            Text(
              screenName
                  ? "Payment has been captured successfully, Continue to activate your subscription"
                  : "The OTP was successfully verified\nWelcome to Diet Done",
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall,
            ),
            kHeight(132),
            CustomElevatedButton(
                theme: theme,
                onTap: screenName
                    ? () async {
                  print("purchase success home clicked for activation");
                        await ActiveSubscriptionAPiService()
                            .activeSubscription();

                      }
                    : () {
                        Get.to(AddressForm(
                          onTap: () async {
                            // Get.to(AboutMeScreen());
                            signUpController.areaId =
                                await areaBlockController.selectedArea.value.id;
                            signUpController.blockName =
                                await areaBlockController
                                    .selectedBlock.value.id;
                            log("${signUpController.areaId} ${signUpController.blockName}");

                            profileConfigController.validation();
                          },
                        ));
                      },
                text: screenName ? "Home" : "Continue")
          ],
        ),
      ),
    );
  }
}
