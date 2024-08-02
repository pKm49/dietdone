import 'package:diet_diet_done/auth/sign_up/widget/Clip_path.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/calendar_controller.dart';
import 'package:diet_diet_done/diet_delivery/calendar/widgets/calendar_widget.dart';
import 'package:diet_diet_done/profile_config/controller/subscription_plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final calendarController = Get.find<CalendarController>();
    final subscriptionController = Get.find<SubscriptionPlanController>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kLightPrimaryColor,
      ),
      body: Column(
        children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              height: size.height * 0.1,
              color: kLightPrimaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(
              () => Column(
                children: [
                  const Text(
                    "Today schedule",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  (calendarController.SubscriptionActiveDates.isEmpty || subscriptionController.subscriptionDetails.where((p0) => p0.subscriptionStatus=='in_progress').toList().isEmpty)
                      ? Text("Your Subscription is not yet activated!..")
                      : Card(
                          color: kWhiteColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CalendarWidget(),
                          ),
                        )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
