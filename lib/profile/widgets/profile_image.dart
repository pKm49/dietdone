import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/diet_delivery/home/controller/getProfileController.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage(
      {super.key, required this.size, required this.profileController});

  final Size size;
  final GetProfileController profileController;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: size.width / 2 - 60,
      top: 90,
      child: SizedBox(
          height: 120,
          width: 120,
          child: profileController.profileList.isNotEmpty
              ? CircleAvatar(
                  radius: 60,
                  backgroundImage: Image.network(
                          profileController.profileList[0].profilePicture == ""
                              ? profileImageNetworkLink
                              : profileController
                                  .profileList[0].profilePicture!)
                      .image,
                )
              : CircularProgressIndicator()),
    );
  }
}
