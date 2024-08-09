import 'package:app_settings/app_settings.dart';
import 'package:diet_diet_done/auth/login/view/create_new_pass_screen.dart';
import 'package:diet_diet_done/auth/login/view/forgot_pass_screen.dart';
import 'package:diet_diet_done/auth/sign_up/view/terms_condition_screen.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/profile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const platform = MethodChannel('com.example.diet_diet_done/settings');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Column(
            children: [
              kHeight(15),
              CustomAppBar(title: "Settings"),
              kHeight(15),
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.grey[100],
                child:
                    SvgPicture.asset("assets/settings_icon/settings (2) 1.svg"),
              ),
              kHeight(30),
              SettingListTile(
                svgUrl: 'assets/settings_icon/notification.svg',
                title: 'Notification',
                onTap: () async {
                  try {
                    AppSettings.openAppSettings(type: AppSettingsType.notification);
                    // await platform.invokeMethod('openNotificationSettings');
                  } on Exception catch (e) {

                  }
                },
              ),
              SettingListTile(
                svgUrl: 'assets/settings_icon/Privacy Policy.svg',
                title: 'Terms & Conditions',
                onTap: () => Get.to(TermsAndConditionsScreen()),
              ),
              SettingListTile(
                svgUrl: 'assets/settings_icon/password (1) 1.svg',
                title: 'Change Password',
                onTap: () => Get.to(CreateNewPassScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingListTile extends StatelessWidget {
  const SettingListTile({
    super.key,
    required this.svgUrl,
    required this.title,
    this.onTap,
  });

  final String svgUrl;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: textFieldColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  svgUrl,
                  height: 20,
                ),
                kWidth(5),
                Text(title),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                ),
              ],
            ),
          ),
          kHeight(13),
        ],
      ),
    );
  }
}
