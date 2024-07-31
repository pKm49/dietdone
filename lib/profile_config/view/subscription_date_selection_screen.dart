import 'dart:developer';

import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/profile_config/api_service/create_subscription_service.dart';
import 'package:diet_diet_done/profile_config/controller/subscription_plan_controller.dart';
import 'package:diet_diet_done/profile_config/view/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';

class SubscriptionDateSelectionScreen extends StatelessWidget {
  const SubscriptionDateSelectionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final subscriptionController = Get.find<SubscriptionPlanController>();
    final signUpController = Get.find<SignUpController>();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Select Staring Date",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            GetBuilder<SubscriptionPlanController>(
                builder: (controller) => Text(
                      subscriptionController.selectedStartingDate,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    )),
            CalendarWidget(),
            ElevatedButton(
              onPressed: () async {
                subscriptionController.paymentUrl.value = "";
                Get.to(CheckOutScreen(
                  subscriptionCardIndex:
                  subscriptionController.subscriptionCardIdx.value,
                ));

              },
              child: Text(
                "Continue",
                style: TextStyle(color: kWhiteColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime currentDate = DateTime.now();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildCalendar(),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                currentDate =
                    DateTime(currentDate.year, currentDate.month - 1, 1);
              });
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: const Icon(Icons.arrow_back_ios_rounded, size: 15),
            ),
          ),
          Text(
            '${DateFormat('MMMM yyyy').format(currentDate)}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                currentDate =
                    DateTime(currentDate.year, currentDate.month + 1, 1);
              });
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    final subscriptionController = Get.find<SubscriptionPlanController>();

    List<Widget> rows = [];

    // Add weekdays header
    rows.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (index) {
        return Text(
          getWeekdayAbbreviation(index),
          style: TextStyle(fontWeight: FontWeight.w500, color: kPrimaryColor),
        );
      }),
    ));

    // Add calendar days
    int daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;
    int weekdayOfFirstDay =
        DateTime(currentDate.year, currentDate.month, 1).weekday;
    int currentDay = 1;

    for (int i = 0; i < 6; i++) {
      List<Widget> week = [];

      for (int j = 0; j < 7; j++) {
        DateTime day;
        if (i == 0 && j < weekdayOfFirstDay - 1) {
          int prevMonthDay =
              DateTime(currentDate.year, currentDate.month, 0).day -
                  weekdayOfFirstDay +
                  j +
                  1;
          day = DateTime(currentDate.year, currentDate.month - 1, prevMonthDay);
        } else if (currentDay > daysInMonth) {
          int nextMonthDay = currentDay - daysInMonth;
          day = DateTime(currentDate.year, currentDate.month + 1, nextMonthDay);
          currentDay++;
        } else {
          day = DateTime(currentDate.year, currentDate.month, currentDay);
          currentDay++;
        }

        bool isEnabled =
            day.isAfter(DateTime.now().subtract(Duration(days: 1)));

        Widget dayWidget = Expanded(
          child: GestureDetector(
            onTap: isEnabled
                ? () {
                    setState(() {
                      selectedDate = day;
                      subscriptionController.dateTimeNow = selectedDate;
                      subscriptionController.selectedDate =
                          DateFormat("yyyy-MM-dd").format(selectedDate);
                      subscriptionController.selectedStartingDate =
                          DateFormat("dd-MM-yyyy").format(selectedDate);
                      subscriptionController.update();
                      // print(subscriptionController.dateTimeNow);
                      // Perform your action when a date is selected
                      print('Selected Date: $selectedDate');
                    });
                  }
                : null,
            child: Column(
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: selectedDate != null && selectedDate == day
                        ? kPrimaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          day.day.toString(),
                          style: TextStyle(
                            color: selectedDate != null && selectedDate == day
                                ? Colors.white
                                : isEnabled
                                    ? Colors.black
                                    : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        );

        week.add(dayWidget);
      }

      rows.add(Row(children: week));
    }

    return Column(children: rows);
  }

  String getWeekdayAbbreviation(int weekday) {
    List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[weekday % 7];
  }
}
