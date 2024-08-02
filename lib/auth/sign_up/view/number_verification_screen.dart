import 'package:country_picker/country_picker.dart';
import 'package:diet_diet_done/auth/sign_up/api/send_otp_service.dart';
import 'package:diet_diet_done/auth/sign_up/api/user_exist_checking_api.dart';
import 'package:diet_diet_done/auth/sign_up/controller/local_controller.dart';
import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/auth/sign_up/firebase/sign_up_using_firebase.dart';
import 'package:diet_diet_done/auth/sign_up/widget/text_field.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constraints/const_colors.dart';
import '../widget/custom_app_bar.dart';

class NumberVerificationScreen extends StatelessWidget {
  const NumberVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final singUpLocalController = Get.find<LocalController>();
    final fireBaseController = Get.find<SignUpUsingFirebaseController>();
    final signUpController = Get.find<SignUpController>();
    final Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final localController = Get.find<LocalController>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        iconColor: kPrimaryColor,
        onTapBackButton: () {
          Get.back();
        },
        onTapIconButton: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            kHeight(30),
            SizedBox(
              height: size.height * 0.3,
              child: Image.asset("assets/illustrations/Mobile app.png"),
            ),
            kHeight(20),
            Text(
              "Verify Your Number",
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            kHeight(12),
            Text(
              "Please enter your country &\nyour phone number",
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall,
            ),
            kHeight(44),
            Row(
              children: [
                // Container(
                //   height: 56.4,
                //   width: size.width * 0.15,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: textFieldColor,
                //       border: Border.all(color: borderColor)),
                //   child: InkWell(
                //     onTap: () {
                //       showCountryPicker(
                //         countryListTheme: CountryListThemeData(
                //             bottomSheetHeight: size.height * 0.7),
                //         context: context,
                //         onSelect: (value) {
                //           localController.changeCountry(value);
                //         },
                //       );
                //     },
                //     child: GetBuilder<LocalController>(
                //       builder: (controller) => Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(localController.selectedCountry.flagEmoji),
                //           const Icon(Icons.arrow_drop_down)
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // kWidth(10),
                Expanded(
                    child: Form(
                  key: signUpController.numberKey,
                  child: CustomTextField(
                    validator: (phoneNumber) => singUpLocalController.validate(
                        phoneNumber, "Please enter your phone number"),
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    hintText: "+${localController.selectedCountry.phoneCode}",
                    controller: signUpController.phoneNumberController,
                    obscure: false,
                  ),
                ))
              ],
            ),
            kHeight(37),
            Obx(
              () => fireBaseController.isLoading.value
                  ? CircularProgressIndicator()
                  : CustomElevatedButton(
                      theme: theme,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                "Are you sure you have entered the correct mobile number?",
                                style: TextStyle(fontSize: 13),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      if (signUpController
                                          .numberKey.currentState!
                                          .validate()) {
                                        Get.back();
                                        final message =
                                            await UserExistCheckingAPiService()
                                                .userExistChecking();
                                        if (message ==
                                            "Customer with mobile ${signUpController.phoneNumberController.text} exists.") {
                                          Get.defaultDialog(
                                            contentPadding: EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                bottom: 20),
                                            titlePadding: EdgeInsets.all(20),
                                            title: "Mobile already in use",
                                            content: Text(
                                              "Customer with mobile ${signUpController.phoneNumberController.text} already exists.",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            textConfirm: "OK",
                                            onConfirm: () => Get.back(),
                                          );
                                          // Get.snackbar("Use another number",
                                          //     "Customer with mobile ${signUpController.phoneNumberController.text} exists.",
                                          //     backgroundColor: kPrimaryColor,
                                          //     colorText: kWhiteColor);
                                        } else {
                                          signUpController.mobileNumber =
                                              signUpController
                                                  .phoneNumberController.text;
                                          OTPService().sendOTP();
                                        }
                                      }
                                    },
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(color: kPrimaryColor),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("No")),
                              ],
                            );
                          },
                        );
                      },
                      text: "Continue"),
            )
          ],
        ),
      ),
    );
  }
}
