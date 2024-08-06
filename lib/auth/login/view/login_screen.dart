import 'package:diet_diet_done/auth/login/controller/login_controller.dart';
import 'package:diet_diet_done/auth/login/view/forgot_pass_screen.dart';
import 'package:diet_diet_done/auth/login/widget/login_with_text.dart';

import 'package:diet_diet_done/auth/login/widget/social_media_login.dart';
import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/auth/sign_up/view/sign_up_screen.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final signUpController = Get.find<SignUpController>();
  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
                child: Image.asset(
              "assets/background_image/jpeg-optimizer_pexels-nataliya-vaitkevich-5794883.jpg",
              fit: BoxFit.cover,
            )),
            Container(
              color: Colors.black.withOpacity(0.6),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 31),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  kHeight(25),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: const Image(
                          image: AssetImage("assets/logo/Group 13233.png"))),
                  const Text(
                    "Welcome back!",
                    style: TextStyle(
                        fontSize: 30,
                        color: kWhiteColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: controller.phoneNumberController,
                          validator: (number) =>
                              controller.validateNumber(number),
                          decoration: InputDecoration(
                            hintText: "Enter your Mobile Number",
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            fillColor: kWhiteColor,
                            filled: true,
                          ),
                        ),
                        kHeight(10),
                        Obx(
                          () => TextFormField(
                            obscureText: controller.isPasswordVisible.value,
                            controller: controller.passwordController,
                            validator: (password) =>
                                controller.validatePassword(password),
                            decoration: InputDecoration(
                              hintText: "Enter your password",
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.isPasswordVisible.toggle();
                                  },
                                  icon: Icon(controller.isPasswordVisible.value
                                      ? Icons.visibility_off
                                      : Icons.remove_red_eye_outlined)),
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              fillColor: kWhiteColor,
                              filled: true,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Get.to(ForgotPassScreen());
                                },
                                child: const Text("Forget Password?",
                                    style: TextStyle(
                                        color: kWhiteColor,
                                        fontWeight: FontWeight.w600))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        child: Text(
                          "Login",
                          style: theme.textTheme.labelLarge,
                        ),
                        onPressed: () async {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          await preferences.setString(
                              "mobile", controller.phoneNumberController.text);
                          signUpController.mobileNumber =
                              controller.phoneNumberController.text;
                          controller.onLogin();
                        },
                      ),
                      kHeight(10),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(const SignUpScreen());
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kWhiteColor),
                      ),
                      // kHeight(10),
                      // const LoginWithText(),
                      // kHeight(15),
                      // SocialMediaLogin(
                      //   size: size,
                      //   color: Colors.white,
                      //   appleLogoImageUrl: "assets/logo/icons8-apple.svg",
                      // ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
