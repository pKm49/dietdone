import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/calendar_controller.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/diet_menu_controller.dart';
import 'package:diet_diet_done/diet_delivery/calendar/view/delivery_meal_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final calendarController = Get.put(CalendarController());
  final dietController = Get.put(DietMenuController());
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildCalendar(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              setState(() {
                currentDate =
                    DateTime(currentDate.year, currentDate.month - 1, 1);
              });
            },
          ),
          Text(
            '${DateFormat('MMMM yyyy').format(currentDate)}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color:
                  Colors.black, // Replace kLightPrimaryColor with actual color
            ),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () {
              setState(() {
                currentDate =
                    DateTime(currentDate.year, currentDate.month + 1, 1);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    List<Widget> rows = [];

    // Add weekdays header
    rows.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (index) {
        return Text(
          getWeekdayAbbreviation(index),
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
        );
      }),
    ));

    DateTime today = DateTime.now();
    int daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;
    int weekdayOfFirstDay =
        DateTime(currentDate.year, currentDate.month, 1).weekday;

    int currentDay = 1;
    bool started = false;

    while (currentDay <= daysInMonth || !started) {
      List<Widget> week = [];
      for (int j = 1; j <= 7; j++) {
        if (currentDay > daysInMonth) {
          week.add(Expanded(child: Container(height: 35)));
        } else if (!started && j < weekdayOfFirstDay) {
          week.add(Expanded(child: Container(height: 35)));
        } else {
          started = true;
          DateTime day =
              DateTime(currentDate.year, currentDate.month, currentDay);
          if (day.isAfter(today.subtract(Duration(days: 1)))) {
            week.add(
              Expanded(
                child: InkWell(
                  onDoubleTap: () {
                    Get.to(MealSelectionScreen2());
                  },
                  onTap: () {
                    setState(() {
                      calendarController.selectedDate.value = day;
                      dietController.dietMenuSelectedDate = day;
                    });
                  },
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: calendarController.selectedDate.value == day
                          ? kPrimaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        currentDay.toString(),
                        style: TextStyle(
                            color: calendarController.selectedDate.value == day
                                ? Colors.white
                                : kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            week.add(
              Expanded(
                child: Container(
                  height: 35,
                  child: Center(
                    child: Text(
                      currentDay.toString(),
                      style: TextStyle(
                        color: Colors
                            .grey, // Change the text color for disabled dates
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          currentDay++;
        }
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
