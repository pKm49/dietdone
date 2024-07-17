import 'package:diet_diet_done/auth/sign_up/api/send_otp_service.dart';
import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/auth/sign_up/firebase/sign_up_using_firebase.dart';
import 'package:diet_diet_done/auth/sign_up/widget/custom_app_bar.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pinput/pinput.dart';

import '../../../core/constraints/const_colors.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
  });
  // final String verificationId;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    final fireBaseController = Get.find<SignUpUsingFirebaseController>();

    final signUpController = Get.find<SignUpController>();
    final Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        iconColor: kPrimaryColor,
        onTapBackButton: () {
          Get.back();
        },
        onTapIconButton: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            kHeight(71),
            SizedBox(
              height: size.height * 0.27,
              width: size.height * 0.27,
              child: Image.asset("assets/illustrations/Group 13043.png"),
            ),
            kHeight(20),
            Text(
              "Verification Code",
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            kHeight(12),
            Text(
              "Please enter OTP code sent\nto your phone number",
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall,
            ),
            kHeight(30),
            Pinput(
              keyboardType: TextInputType.number,
              length: 6,
              controller: signUpController.otpController,
              submittedPinTheme: PinTheme(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: kBlackColor))),
                textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            kHeight(61),
            fireBaseController.isLoading.value
                ? CircularProgressIndicator()
                : CustomElevatedButton(
                    theme: theme,
                    onTap: () {
                      toast("Loading....");
                      // signUpController.sendOTP(widget.verificationId);
                      OTPService().verifyOTP();
                      // Get.to(OTPSuccessScreen(screenName: false));
                    },
                    text: "Confirm")
          ],
        ),
      ),
    );
  }
}
