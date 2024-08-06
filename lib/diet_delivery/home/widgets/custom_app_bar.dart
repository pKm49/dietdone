import 'dart:developer';

import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/diet_delivery/home/api/get_support_service.dart';
import 'package:diet_diet_done/diet_delivery/home/controller/getProfileController.dart';
import 'package:diet_diet_done/diet_delivery/home/controller/home_screen_controller.dart';
import 'package:diet_diet_done/diet_delivery/home/view/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class CustomAppBarTile extends StatelessWidget {
  const CustomAppBarTile(
      {super.key,
      required this.size,
      required this.profileController,
      required this.homeController});

  final Size size;
  final GetProfileController profileController;
  final HomeController homeController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kHeight(size.height * 0.05),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: ListTile(
                  leading: profileController.profileList.isEmpty
                      ? CircleAvatar(
                          child: Shimmer.fromColors(
                              child: CircleAvatar(),
                              baseColor: Colors.grey,
                              highlightColor: Colors.white))
                      : CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              profileController.profileList[0].profilePicture ==
                                      ""
                                  ? profileImageNetworkLink
                                  : profileController
                                      .profileList[0].profilePicture!),
                        ),
                  title: profileController.profileList.isEmpty
                      ? SizedBox(
                          child: Shimmer.fromColors(
                              child: Text("........."),
                              baseColor: Colors.grey,
                              highlightColor: Colors.white),
                        )
                      : Text(
                          "${profileController.profileList[0].firstName} ${profileController.profileList[0].lastName}",
                          style: TextStyle(color: kWhiteColor),
                        ),
                  subtitle: profileController.profileList.isEmpty
                      ? SizedBox(
                          child: Shimmer.fromColors(
                              child: Text("0000"),
                              baseColor: Colors.grey,
                              highlightColor: Colors.white),
                        )
                      : Text(
                          profileController.profileList[0].customerCode,
                          style: TextStyle(color: kWhiteColor),
                        ),
                  trailing: InkWell(
                    onTap: () {},
                    child: InkWell(
                      onTap: () => Get.to(NotificationScreen(
                        homeController: homeController,
                      )),
                      child: SvgPicture.asset(
                        "assets/icon/Notification.svg",
                        color: kWhiteColor,
                        height: 25,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                  onTap: () async {
                    toast("Redirecting to phone..");
                    final supportNumber =
                        await GetSupportNumberApiService().getSupportNumber();
                    log(supportNumber);
                    final Uri url = Uri(
                      scheme: 'tel',
                      path: supportNumber
                    );
                    bool canL = await UrlLauncher.canLaunchUrl(url);
                    print(canL);
                    UrlLauncher.launchUrl(url);
                  },
                  child: SvgPicture.asset(
                    "assets/icon/Connect.svg",
                    // ignore: deprecated_member_use
                    color: kWhiteColor,
                  )),
              kWidth(15)
            ],
          ),
        ),
      ],
    );
  }
}
