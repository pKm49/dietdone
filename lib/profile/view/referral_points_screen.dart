import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/diet_delivery/home/controller/getProfileController.dart';
import 'package:diet_diet_done/profile/controller/Profile_controller.dart';
import 'package:diet_diet_done/profile/widgets/custom_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ReferralPointScreen extends StatelessWidget {
  const ReferralPointScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final profileController = Get.find<GetProfileController>();
    final refferralProfileController = Get.find<ProfileController>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                title: "Your Referral Points",
              ),
              kHeight(20),
              Container(
                padding: const EdgeInsets.all(25),
                width: size.width * 0.7,
                color: textFieldColor,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundImage: Image.network(
                              profileController.profileList[0].profilePicture ==
                                      ""
                                  ? profileImageNetworkLink
                                  : profileController
                                      .profileList[0].profilePicture!)
                          .image,
                    ),
                    kHeight(10),
                    profileController.profileList[0].email.isEmpty
                        ? SizedBox()
                        : Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: kLightPrimaryColor),
                            child: Text(
                              profileController.profileList[0].email,
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                    kHeight(5),
                    const Text("Earnings"),
                    kHeight(5),
                    Text(
                      refferralProfileController.referralData["refferelEarning"]
                          .toString(),
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              kHeight(50),
              const Row(
                children: [
                  Text("Referral Code:"),
                ],
              ),
              kHeight(20),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: textFieldColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    refferralProfileController.referralData["referralCode"],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              kHeight(30),
              ElevatedButton.icon(
                onPressed: () async {
                  await Share.share(
                      "Share Your health journey with friends! Invite them to join DONE family using your referral code H1jc0Y49  and earn rewards. Let's spread wellness");
                },
                icon: const Icon(
                  Icons.share,
                  color: kWhiteColor,
                ),
                label: Text(
                  "Share",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(size.width * 0.3, 40)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
