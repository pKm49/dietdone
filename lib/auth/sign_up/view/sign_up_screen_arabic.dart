import 'package:diet_diet_done/auth/login/widget/social_media_login.dart';
import 'package:diet_diet_done/auth/sign_up/controller/local_controller.dart';
import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/auth/sign_up/view/number_verification_screen.dart';
import 'package:diet_diet_done/auth/sign_up/widget/Clip_path.dart';
import 'package:diet_diet_done/auth/sign_up/widget/custom_app_bar.dart';
import 'package:diet_diet_done/auth/sign_up/widget/text_field.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constraints/const_colors.dart';

class SignUpScreenArabic extends StatelessWidget {
  const SignUpScreenArabic({super.key});

  @override
  Widget build(BuildContext context) {
    final singUpLocalController = Get.find<LocalController>();
    final singUpController = Get.find<SignUpController>();
    final Size size = MediaQuery.of(context).size;
    final controller = Get.find<LocalController>();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        iconColor: kWhiteColor,
        backgroundColor: kPrimaryColor,
        onTapBackButton: () {
          Get.back();
        },
        onTapIconButton: () {
          Get.dialog(AlertDialog(
            title: Text("Change Language To"),
            actions: [
              TextButton(
                  onPressed: () {
                    controller.changeLanguage("ar", "AE");
                  },
                  child: Text("عربي")),
              TextButton(
                  onPressed: () {
                    controller.changeLanguage("ar", "AE");
                  },
                  child: Text("English")),
            ],
          ));
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CurvedClipPath(
              size: size,
              color: kPrimaryColor,
            ),
            SizedBox(
              height: size.height - 250,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Form(
                      key: singUpController.englishKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            obscure: false,

                            validator: (firstName) => singUpLocalController
                                .validateArabic(firstName, "Please enter your name"),
                            hintText: "First name (Arabic)*".tr,
                            controller: singUpController.arabicFirstName,
                          ),
                          kHeight(15),
                          CustomTextField(
                            obscure: false,
                            validator: (lastName) => singUpLocalController
                                .validateArabic(lastName, "Please enter your name"),
                            hintText: "Last name (Arabic)*".tr,
                            controller: singUpController.arabicLastName,
                          ),
                          kHeight(15),
                          CustomTextField(
                            obscure: false,
                            validator: (lastName) => singUpLocalController
                                .checkIfEmailFormValid(lastName),
                            hintText: "Enter your email",
                            controller: singUpController.emailController,
                          ),
                          kHeight(15),
                          CustomTextField(
                            obscure: true,
                            validator: (password) {
                              if (password!.isEmpty) {
                                return "Please enter a Password";
                              }
                              if (password !=
                                  singUpController.confirmPassController.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                            hintText: "Password",
                            controller: singUpController.passwordController,
                          ),
                          kHeight(15),
                          CustomTextField(
                            obscure: true,
                            validator: (confirmPassword) {
                              if (confirmPassword!.isEmpty) {
                                return "Please confirm your password";
                              }
                              if (confirmPassword !=
                                  singUpController.passwordController.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                            hintText: "Confirm Password",
                            controller: singUpController.confirmPassController,
                          ),
                        ],
                      ),
                    ),
                    kHeight(25),
                    CustomElevatedButton(
                        theme: theme,
                        onTap: () {
                          if (singUpController.englishKey.currentState!
                              .validate()) {
                            Get.to(const NumberVerificationScreen());
                          }
                        },
                        text: "Continue".tr),
                    // kHeight(10),
                    // Row(
                    //   children: [
                    //     const Expanded(
                    //       child:
                    //           Divider(thickness: 1, color: Color(0xFFDADADA)),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 10),
                    //       child: Text(
                    //         "Or Login with".tr,
                    //       ),
                    //     ),
                    //     const Expanded(
                    //       child:
                    //           Divider(thickness: 1, color: Color(0xFFDADADA)),
                    //     ),
                    //   ],
                    // ),
                    // SocialMediaLogin(
                    //   appleLogoImageUrl: "assets/logo/cib_apple.svg",
                    //   size: size,
                    //   color: const Color(0xFFDADADA),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
