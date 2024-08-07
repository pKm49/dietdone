import 'dart:ui';

import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/diet_delivery/home/controller/getProfileController.dart';
import 'package:diet_diet_done/profile_config/controller/subscription_plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileDIetCard extends StatelessWidget {
  const ProfileDIetCard(
      {super.key,
      required this.size,
      required this.profileController,
      required this.subscriptionController});

  final Size size;
  final GetProfileController profileController;
  final SubscriptionPlanController subscriptionController;

  @override
  Widget build(BuildContext context) {
    final endDateTime = subscriptionController.subscriptionDetails.where((p0) => p0.subscriptionStatus=='in_progress').toList().isNotEmpty?

    subscriptionController.subscriptionDetails.where((p0) => p0.subscriptionStatus=='in_progress').toList()[0].endDate:DateTime.now();
    final endDate = DateFormat("dd-MM-yyyy").format(endDateTime);
    final currentDate = DateTime.now();
    Duration difference = endDateTime.difference(currentDate);
    int remainingDays = difference.inDays;
    return Center(
      child: Container(
        margin: const EdgeInsets.all(5),
        height: size.height * 0.3,
        width: size.width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white.withOpacity(0.2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(
              color: const Color.fromRGBO(255, 255, 255, 1).withOpacity(0.25),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    kHeight(size.height * 0.1),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(subscriptionController.subscriptionDetails.where((p0) => p0.subscriptionStatus=='in_progress').toList().isNotEmpty?
                          subscriptionController
                              .subscriptionDetails.where((p0) => p0.subscriptionStatus=='in_progress').toList()[0].planName:"",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 26,
                              color: kWhiteColor,
                              fontWeight: FontWeight.w700)),
                    ),
                    Text(
                      "Ends on ${endDate}",
                      style: TextStyle(color: kWhiteColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Remain",
                          style: TextStyle(color: kWhiteColor),
                        ),
                        kWidth(5),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: kLightPrimaryColor, width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                              child: Text(
                            "${profileController.profileList.isNotEmpty?profileController.profileList[0].subscriptionEndIn:remainingDays}",
                            style: TextStyle(
                                fontSize: 25, color: kLightPrimaryColor),
                          )),
                        ),
                        kWidth(5),
                        const Text(
                          "Days",
                          style: TextStyle(color: kWhiteColor),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
