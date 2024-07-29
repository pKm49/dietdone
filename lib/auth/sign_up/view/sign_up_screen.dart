import 'package:diet_diet_done/auth/login/widget/social_media_login.dart';
import 'package:diet_diet_done/auth/sign_up/controller/local_controller.dart';
import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/auth/sign_up/view/sign_up_screen_arabic.dart';
import 'package:diet_diet_done/auth/sign_up/view/terms_condition_screen.dart';
import 'package:diet_diet_done/auth/sign_up/widget/Clip_path.dart';
import 'package:diet_diet_done/auth/sign_up/widget/custom_app_bar.dart';
import 'package:diet_diet_done/auth/sign_up/widget/text_field.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constraints/const_colors.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                    Get.back();
                  },
                  child: Text("عربي")),
              TextButton(
                  onPressed: () {
                    controller.changeLanguage("en", "US");
                    Get.back();
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
                    InkWell(
                      onTap: () async {
                        await singUpLocalController.pickImageFromGallery();
                        singUpLocalController.imageToBase64();
                      },
                      child: GetBuilder<LocalController>(
                        builder: (controller) => CircleAvatar(
                          radius: 62,
                          backgroundColor: kPrimaryColor,
                          child: CircleAvatar(
                              radius: 58,
                              backgroundImage: controller.selectedImage == null
                                  ? AssetImage(
                                      "assets/profile_icon/add_profile_image.jpg",
                                    ) as ImageProvider
                                  : FileImage(controller.selectedImage!)),
                        ),
                      ),
                    ),
                    Text(
                      "Select you profile image".tr,
                      textAlign: TextAlign.center,
                    ),
                    Form(
                      key: singUpController.arabicKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            obscure: false,
                            validator: (firstName) => singUpLocalController
                                .validate(firstName, "Please enter your name"),
                            hintText: "First name (English)*".tr,
                            controller: singUpController.englishFirstName,
                          ),
                          kHeight(15),
                          CustomTextField(
                            obscure: false,
                            validator: (lastName) => singUpLocalController
                                .validate(lastName, "Please enter your name"),
                            hintText: "Last name (English)*".tr,
                            controller: singUpController.englishLastName,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Obx(
                                () => Checkbox(
                                  activeColor: kPrimaryColor,
                                  value: singUpLocalController
                                      .termsAndCondition.value,
                                  onChanged: (newValue) {
                                    singUpLocalController.termsAndCondition
                                        .toggle();
                                  },
                                ),
                              ),
                              Text(
                                "Accept ",
                                style: TextStyle(),
                              ),
                              InkWell(
                                onTap: () => Get.to(
                                  TermsAndConditionsScreen(),
                                ),
                                child: Text(
                                  "Terms and conditions",
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    kHeight(25),
                    CustomElevatedButton(
                        theme: theme,
                        onTap: () async {
                          if (!singUpLocalController.termsAndCondition.value) {
                            Get.snackbar("Terms and conditions",
                                "Please agree to the terms and conditions"
                                ,backgroundColor: kPrimaryColor, colorText: kWhiteColor);
                          } else if (singUpController.arabicKey.currentState!
                              .validate()) {
                            Get.to(const SignUpScreenArabic(),
                                transition: Transition.rightToLeft,
                                duration: Duration(milliseconds: 300));
                          }
                        },
                        text: "Continue".tr),
                    kHeight(10),
                    Row(
                      children: [
                        const Expanded(
                          child:
                              Divider(thickness: 1, color: Color(0xFFDADADA)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Or Login with".tr,
                          ),
                        ),
                        const Expanded(
                          child:
                              Divider(thickness: 1, color: Color(0xFFDADADA)),
                        ),
                      ],
                    ),
                    SocialMediaLogin(
                      appleLogoImageUrl: "assets/logo/cib_apple.svg",
                      size: size,
                      color: const Color(0xFFDADADA),
                    ),
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
