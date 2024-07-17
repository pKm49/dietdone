import 'package:diet_diet_done/profile_config/api_service/appointment_booking_service.dart';
import 'package:diet_diet_done/profile_config/api_service/create_subscription_service.dart';
import 'package:diet_diet_done/profile_config/controller/subscription_plan_controller.dart';
import 'package:diet_diet_done/profile_config/view/checkout_screen.dart';
import 'package:diet_diet_done/profile_config/view/subscription_date_selection_screen.dart';

import 'package:diet_diet_done/widget/subscription_plan_card_list_view.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionSCreen extends StatelessWidget {
  const SubscriptionSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    late final subscriptionController = Get.find<SubscriptionPlanController>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      subscriptionController.fetchSubscriptionPlan();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Subscription"),
        centerTitle: true,
        backgroundColor: kWhiteColor,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_sharp)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            SubscriptionPlanTopSection(theme: theme),
            SubscriptionPlanCardListView(controller: subscriptionController),
            kHeight(10),
            ElevatedButton(
                onPressed: () async {
                  if (subscriptionController.subscriptionId == 0) {
                    Get.snackbar(
                        "Please Select", "Chose your Subscription plan");
                  } else {
                    Get.to(SubscriptionDateSelectionScreen());
                  }
                },
                child: Text(
                  "Continue to purchase",
                  style: theme.textTheme.labelLarge,
                )),
            kHeight(10),
          ],
        ),
      ),
    );
  }
}

class SubscriptionPlanTopSection extends StatelessWidget {
  const SubscriptionPlanTopSection({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Select Your Choice",
          style: theme.textTheme.titleMedium,
        ),
        InkWell(
          onTap: () => Get.dialog(AlertDialog(
            title: const Text("Book a Dietician?"),
            content: const Text(
                "You can request a consultation by pressing yes. Our representative will contact you soon."),
            actions: [
              TextButton(
                  onPressed: () async {
                    await AppointmentBookingApiServices().appointmentBooking();
                    Get.back();
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: kPrimaryColor),
                  )),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("No")),
            ],
          )),
          child: Container(
            height: 30,
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                kWidth(10),
                const Icon(
                  Icons.calendar_month_outlined,
                  color: kWhiteColor,
                  size: 15,
                ),
                kWidth(3),
                const Text(
                  "Book Appointment",
                  style: TextStyle(color: kWhiteColor, fontSize: 12),
                ),
                kWidth(10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
