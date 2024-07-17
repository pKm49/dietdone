import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/profile_config/controller/profile_config_controller.dart';
import 'package:diet_diet_done/profile_config/view/user_origin_screen.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/profile_config/widgets/gender_selecting_widget.dart';
import 'package:diet_diet_done/widget/custom_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutMeScreen extends StatelessWidget {
  const AboutMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.find<SignUpController>();
    final Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppBarBackButton(),
            kWidth(20),
            Text(
              "About Me",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.language,
                      color: kPrimaryColor,
                    )),
                Text(
                  "English",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                ),
              ],
            )
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Gender",
                  style: theme.textTheme.titleMedium,
                ),
                kHeight(30),
                GetBuilder<ProfileConfigController>(
                  builder: (controller) =>
                      GenderSelectingWidget(size: size, theme: theme),
                ),
              ],
            ),
          ),
          kHeight(size.height * 0.05),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "How tall are You?",
                      style: theme.textTheme.titleMedium,
                    ),
                    Container(
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color(0xFFDFD1D7),
                      ),
                      child: const Center(child: Text("Cm")),
                    )
                  ],
                ),
                kHeight(25),
                Row(
                  children: [
                    kWidth(size.width * 0.31),
                    Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: signUpController.heightController,
                          decoration: InputDecoration(hintText: "00 cm"),
                          keyboardType: TextInputType.number,
                        )),
                    kWidth(size.width * 0.31),
                  ],
                )
              ],
            ),
          ),
          kHeight(size.height * 0.05),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Whats your weight?",
                  style: theme.textTheme.titleMedium,
                ),
                Container(
                  height: 30,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: const Color(0xFFDFD1D7),
                  ),
                  child: const Center(child: Text("Kg")),
                )
              ],
            ),
          ),
          // const HighlightCenterNumberList(),
          // const Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Icon(
          //       Icons.arrow_drop_down,
          //       size: 60,
          //     ),
          //   ],
          // ),
          kHeight(20),
          Row(
            children: [
              kWidth(size.width * 0.35),
              Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: signUpController.weightController,
                    decoration: InputDecoration(hintText: "00 kg"),
                    keyboardType: TextInputType.number,
                  )),
              kWidth(size.width * 0.35),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
                onPressed: () {
                  if (signUpController.heightController.text.isEmpty ||
                      signUpController.weightController.text.isEmpty) {
                    Get.snackbar("Please fill the column",
                        "Enter your Height and Weight in the column");
                  } else {
                    Get.to(const UserOriginScreen());
                  }
                },
                child: Text(
                  "Done",
                  style: theme.textTheme.labelLarge,
                )),
          ),
          kHeight(20)
        ],
      ),
    );
  }
}
