import 'package:diet_diet_done/auth/sign_up/controller/local_controller.dart';
import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/auth/sign_up/widget/custom_app_bar.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserOriginScreen extends StatelessWidget {
  const UserOriginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.find<LocalController>();
    final signUpController = Get.find<SignUpController>();

    return Scaffold(
      appBar: CustomAppBar(
        iconColor: kPrimaryColor,
        onTapBackButton: () {
          Get.back();
        },
        onTapIconButton: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            kHeight(20),
            Text(
              "Let us know how you found about us",
              style: theme.textTheme.titleMedium,
            ),
            kHeight(20),
            Row(
              children: [
                Obx(
                  () => Radio(
                    activeColor: kBlackColor,
                    value: 1,
                    groupValue: controller.selectedValueSource.value,
                    onChanged: (value) {
                      controller.selectValue(value as int);
                      signUpController.source = "social";
                    },
                  ),
                ),
                const Text('Social media'),
              ],
            ),
            Row(
              children: [
                Obx(
                  () => Radio(
                    activeColor: kBlackColor,
                    value: 2,
                    groupValue: controller.selectedValueSource.value,
                    onChanged: (value) {
                      controller.selectValue(value as int);
                      signUpController.source = "friend";
                    },
                  ),
                ),
                const Text('Through a friend'),
              ],
            ),
            Row(
              children: [
                Obx(
                  () => Radio(
                    activeColor: kBlackColor,
                    value: 3,
                    groupValue: controller.selectedValueSource.value,
                    onChanged: (value) {
                      controller.selectValue(value as int);
                      signUpController.source = "other";
                    },
                  ),
                ),
                const Text('Others'),
              ],
            ),
            Obx(
              () => Visibility(
                visible: controller.selectedValueSource.value == 3,
                child: TextFormField(
                  controller: signUpController.otherSourceController,
                  decoration:
                      InputDecoration(hintText: "How did you hear about us"),
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  signUpController.onSignUp();
                },
                child: Text(
                  "Done",
                  style: theme.textTheme.labelLarge,
                )),
            kHeight(50)
          ],
        ),
      ),
    );
  }
}
