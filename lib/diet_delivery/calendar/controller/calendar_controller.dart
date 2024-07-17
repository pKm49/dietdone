import 'dart:developer';

import 'package:diet_diet_done/diet_delivery/calendar/api/freeze_api_service.dart';
import 'package:diet_diet_done/profile_config/controller/subscription_plan_controller.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class CalendarController extends GetxController {
  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
  final subscriptionPlanController = Get.find<SubscriptionPlanController>();
  RxList<DateTime> freezedSelectedDate = <DateTime>[].obs;
  RxInt mealsSelectionCount = 0.obs;
  RxList selectedMealsListCount = [].obs;
  RxMap SubscriptionActiveDates = {}.obs;
  Future freezeCalendar() async {
    List formattedDates = freezedSelectedDate
        .map((element) => DateFormat("yyyy-MM-dd").format(element))
        .toList();
    log(formattedDates.toString());
    log(freezedSelectedDate.toString(), name: "selected date");
    log(
        subscriptionPlanController.subscriptionDetails[0].subscriptionId
            .toString(),
        name: "subId");
    await FreezeDateApiService().freezeSubscription(
        await subscriptionPlanController.subscriptionDetails[0].subscriptionId,
        formattedDates);
  }
}
