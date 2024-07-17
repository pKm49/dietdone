import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/diet_delivery/home/controller/getProfileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProfileCardImage extends StatelessWidget {
  const ProfileCardImage(
      {super.key, required this.size, required this.profileController});

  final Size size;
  final GetProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: size.height * 0.235,
      child: CircleAvatar(
        backgroundColor: kWhiteColor,
        radius: 60,
        child: Obx(
          () => profileController.profileList.isEmpty
              ? CircleAvatar(
                  radius: 55,
                  child: Shimmer.fromColors(
                      child: CircleAvatar(
                        radius: 55,
                      ),
                      baseColor: Colors.grey,
                      highlightColor: Colors.white))
              : CircleAvatar(
                  radius: 55,
                  backgroundImage: NetworkImage(
                      profileController.profileList[0].profilePicture == ""
                          ? profileImageNetworkLink
                          : profileController.profileList[0].profilePicture!),
                ),
        ),
      ),
    );
  }
}
