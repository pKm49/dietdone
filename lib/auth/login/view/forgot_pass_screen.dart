import 'package:country_picker/country_picker.dart';
import 'package:diet_diet_done/auth/login/view/login_screen.dart';
import 'package:diet_diet_done/auth/login/view/otp_verification_screen.dart';
import 'package:diet_diet_done/auth/sign_up/controller/local_controller.dart';
import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/auth/sign_up/firebase/sign_up_using_firebase.dart';
import 'package:diet_diet_done/auth/sign_up/widget/text_field.dart';

import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassScreen extends StatelessWidget {
  ForgotPassScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final singUpLocalController = Get.find<LocalController>();
    final signUpController = Get.find<SignUpController>();

    final localController = Get.find<LocalController>();

    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forgot Password?",
              style: theme.textTheme.titleMedium,
            ),
            kHeight(10),
            const Text(
                "Don't worry! It occurs. Please enter the phone number linked with your account."),
            kHeight(50),
            Row(
              children: [
                Container(
                  height: 56.4,
                  width: size.width * 0.15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: textFieldColor,
                      border: Border.all(color: borderColor)),
                  child: InkWell(
                    onTap: () {
                      showCountryPicker(
                        countryListTheme: CountryListThemeData(
                            bottomSheetHeight: size.height * 0.7),
                        context: context,
                        onSelect: (value) {
                          localController.changeCountry(value);
                        },
                      );
                    },
                    child: GetBuilder<LocalController>(
                      builder: (controller) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(localController.selectedCountry.flagEmoji),
                          const Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                  ),
                ),
                kWidth(10),
                Expanded(
                    child: Form(
                  key: signUpController.numberKey,
                  child: CustomTextField(
                    validator: (phoneNumber) => singUpLocalController.validate(
                        phoneNumber, "Please enter your phone number"),
                    keyboardType: TextInputType.phone,
                    hintText: "+${localController.selectedCountry.phoneCode}",
                    controller: signUpController.phoneNumberController,
                    obscure: false,
                  ),
                ))
              ],
            ),
            kHeight(20),
            ElevatedButton(
                onPressed: () {
                  signUpController.forgetPassword();
                },
                style: ElevatedButton.styleFrom(backgroundColor: kBlackColor),
                child: Text(
                  "Send Code",
                  style: theme.textTheme.labelLarge,
                )),
          ],
        ),
      ),
    );
  }
}
