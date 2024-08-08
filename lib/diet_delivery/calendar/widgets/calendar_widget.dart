import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/diet_menu_controller.dart';
import 'package:diet_diet_done/diet_delivery/calendar/view/delivery_meal_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/calendar_controller.dart';
import 'package:overlay_support/overlay_support.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime currentDate = DateTime.now();
  DateTime? selectedDate;
  final calendarController = Get.find<CalendarController>();

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    selectedDate ??= DateTime.now();
    selectedDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          _buildHeader(),
          _buildCalendar(),
        ],
      );
    });
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
                border: Border.all(color: borderColor),
                color: kWhiteColor,
              ),
              child: const Icon(Icons.arrow_back_ios_rounded, size: 15),
            ),
          ),
          Text(
            '${DateFormat('MMMM yyyy').format(currentDate)}',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: kLightPrimaryColor),
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
                border: Border.all(color: borderColor),
                color: kWhiteColor,
              ),
              child: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    List<Widget> rows = [];
    final dietMenuController = Get.find<DietMenuController>();
    // Add weekdays header
    rows.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (index) {
        return Text(getWeekdayAbbreviation(index),
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey));
      }),
    ));

    // Add calendar days
    int daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;
    int weekdayOfFirstDay =
        DateTime(currentDate.year, currentDate.month, 1).weekday;
    int currentDay = 1;
    print("weekdayOfFirstDay");
    print(weekdayOfFirstDay);
    for (int i = 0; i < 6; i++) {
      List<Widget> week = [];

      for (int j = 0; j < 7; j++) {
        DateTime day;
        if (i == 0 && j < weekdayOfFirstDay - 1) {
          print("day");
          print( DateTime(currentDate.year, currentDate.month, 1).add(Duration(days: -1)).day-
              (DateTime(currentDate.year, currentDate.month, 1).add(Duration(days: -1)).weekday-1));
          print( DateTime(currentDate.year, currentDate.month, 1).add(Duration(days: -1)).day-
              (DateTime(currentDate.year, currentDate.month, 1).add(Duration(days: -1)).weekday-1)+ j);
           int prevMonthDay =
               DateTime(currentDate.year, currentDate.month, 1).add(Duration(days: -1)).day-
                   (DateTime(currentDate.year, currentDate.month, 1).add(Duration(days: -1)).weekday-1)+ j ;
           print(prevMonthDay);
          day = DateTime(currentDate.year, currentDate.month - 1, prevMonthDay);
          print(day);
        } else if (currentDay > daysInMonth) {
          int nextMonthDay = currentDay - daysInMonth;
          day = DateTime(currentDate.year, currentDate.month + 1, nextMonthDay);
          currentDay++;
        } else {
          day = DateTime(currentDate.year, currentDate.month, currentDay);
          currentDay++;
        }

        String formattedDate = DateFormat('yyyy-MM-dd').format(day);
        String? dayStatus =
            calendarController.SubscriptionActiveDates[formattedDate];

        Widget dayWidget = Expanded(
          child: GestureDetector(
            onTap: () {
              if(dayStatus != null){
                if (dayStatus == "off-day") {
                  toast("This is an off day");
                } else if (dayStatus == "freezed") {
                  toast("Freezed Date");
                } else if (dayStatus == "delivered") {
                  toast("Meal Already Delivered");
                }  else if (dayStatus == "" ) {
                  toast("Subscription Not Active");
                } else {
                  setState(() {
                    selectedDate = day;
                    dietMenuController.dietMenuSelectedDate.value = day;
                    dietMenuController.update();
                    Get.to(MealSelectionScreen2());
                  });
                }
              }else{
                toast("Subscription Not Active");
              }

            },
            child: Column(
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: selectedDate != null && selectedDate == day
                        ? Colors.amber
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
                                ? kWhiteColor
                                : kLightPrimaryColor,
                          ),
                        ),
                        if (dayStatus == "meal-selected")
                          Icon(Icons.check, size: 12, color: Colors.green),
                        if (dayStatus == "meal-not-selected")
                          SvgPicture.asset("assets/icon/Select.svg"),
                        if (dayStatus == "off-day")
                          Icon(Icons.close, size: 12, color: Colors.red),
                        if (dayStatus == "freezed")
                          Icon(Icons.close, size: 12, color: Colors.blue),
                        if (dayStatus == "delivered")
                          Icon(Icons.fire_truck_rounded,
                              size: 12, color: kPrimaryColor),
                      ],
                    ),
                  ),
                ),
                kHeight(5)
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
