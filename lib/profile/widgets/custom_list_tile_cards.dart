import 'package:diet_diet_done/auth/login/view/login_screen.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/diet_delivery/home/controller/getProfileController.dart';
import 'package:diet_diet_done/profile/controller/Profile_controller.dart';
import 'package:diet_diet_done/profile/view/about_diet_done_screen.dart';
import 'package:diet_diet_done/profile/view/adress_details_screens.dart';
import 'package:diet_diet_done/profile/view/allergies_screen.dart';
import 'package:diet_diet_done/profile/view/edit_profile_screen.dart';
import 'package:diet_diet_done/profile/view/referral_points_screen.dart';
import 'package:diet_diet_done/profile/view/settings_screens.dart';
import 'package:diet_diet_done/profile/view/subscription_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class CustomListTileCards extends StatelessWidget {
  const CustomListTileCards(
      {super.key,
      required this.profileController,
      required this.refferalProfileController});
  final GetProfileController profileController;
  final ProfileController refferalProfileController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OptionListTile(
          onTap: () {
            Get.to(EditProfileScreen(
              profileController: profileController,
            ));
          },
          imageUrl: 'assets/profile_icon/Profile.svg',
          text: 'Profile',
        ),
        OptionListTile(
          onTap: () {
            Get.to(const SubscriptionDetailScreen());
          },
          imageUrl: 'assets/profile_icon/Subscription.svg',
          text: 'Subscription',
        ),
        OptionListTile(
          onTap: () {
            Get.to(const AddressDetailsScreen());
          },
          imageUrl: 'assets/profile_icon/Shipping Address.svg',
          text: 'Shipping Address',
        ),
        OptionListTile(
          onTap: () {
            Get.to(AllergiesScreen());
          },
          imageUrl: 'assets/profile_icon/Group 13232.svg',
          text: 'Allergies',
        ),
        OptionListTile(
          onTap: () {
            Get.to(const ReferralPointScreen());
          },
          imageUrl: 'assets/profile_icon/Logout.svg',
          text: 'Referral Points',
        ),
        OptionListTile(
          onTap: () {
            Get.to(const AboutDietDoneScreen());
          },
          imageUrl: 'assets/profile_icon/About Diet Done.svg',
          text: 'About Diet Done',
        ),
        OptionListTile(
          onTap: () {
            Get.to(const SettingsScreen());
          },
          imageUrl: 'assets/profile_icon/Settings.svg',
          text: 'Display and Notification Settings',
        ),
        OptionListTile(
          onTap: () {
            Get.dialog(AlertDialog(
              title: const Text("Confirm logout?"),
              content: const Text("Are you sure you want to log out?"),
              actions: [
                TextButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.remove("mobile");
                      // firebaseController.signOutFirebase();
                      Get.offAll(LoginScreen());
                    },
                    child: const Text(
                      "Yes",
                      style: TextStyle(color: Colors.red),
                    )),
                TextButton(
                    onPressed: () async {
                      Get.back();
                    },
                    child: const Text(
                      "No",
                    )),
              ],
            ));
          },
          imageUrl: 'assets/profile_icon/Logout.svg',
          text: 'Logout',
        ),
        kHeight(50)
      ],
    );
  }
}

class OptionListTile extends StatelessWidget {
  const OptionListTile({
    super.key,
    required this.onTap,
    required this.imageUrl,
    required this.text,
  });

  final void Function()? onTap;
  final String imageUrl;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        onTap: onTap,
        leading: SvgPicture.asset(imageUrl),
        title: Text(text),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 12,
        ),
      ),
    );
  }
}
