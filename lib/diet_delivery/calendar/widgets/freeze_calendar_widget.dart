import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';

class FreezeCalendarWidget extends StatefulWidget {
  @override
  _FreezeCalendarWidgetState createState() => _FreezeCalendarWidgetState();
}

class _FreezeCalendarWidgetState extends State<FreezeCalendarWidget> {
  final calendarController = Get.put(CalendarController());
  DateTime currentDate = DateTime.now();
  List<DateTime> selectedDates = [];

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
              color: Colors.black,
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
    calendarController.freezedSelectedDate = selectedDates.obs;
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

    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
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
          bool isSubscribedDate =
              calendarController.SubscriptionActiveDates.containsKey(
                  DateFormat('yyyy-MM-dd').format(day));
          String formattedDate = DateFormat('yyyy-MM-dd').format(day);
          String? dayStatus =
              calendarController.SubscriptionActiveDates[formattedDate];

          if (day.isAfter(tomorrow)) {
            week.add(
              Expanded(
                child: InkWell(
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
                          if (selectedDates.contains(day)) {
                            selectedDates.remove(day);
                          } else {
                            selectedDates.add(day);
                          }
                        });
                      }
                    }else{
                      toast("Subscription Not Active");
                    }

                  },
                  child: Container(
                    margin: EdgeInsets.all(3),
                    height: 35,
                    decoration: BoxDecoration(
                      color: selectedDates.contains(day)
                          ? kPrimaryColor
                          : (dayStatus == "freezed"
                              ? Colors.grey
                              : (isSubscribedDate
                                  ? kLightPrimaryColor
                                  : Colors.transparent)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        currentDay.toString(),
                        style: TextStyle(
                          color: selectedDates.contains(day) ||
                                  isSubscribedDate ||
                                  dayStatus == "freezed"
                              ? Colors.white
                              : kPrimaryColor,
                        ),
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
                        color: Colors.grey,
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
