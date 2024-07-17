import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/calendar_controller.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/diet_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';

class WeekBasedCalendar extends StatefulWidget {
  @override
  _WeekBasedCalendarState createState() => _WeekBasedCalendarState();
}

class _WeekBasedCalendarState extends State<WeekBasedCalendar> {
  late PageController _pageController;
  DateTime _currentDate = DateTime.now();
  DateTime? _selectedDate;
  final calendarController = Get.find<CalendarController>();
  final dietMenuController = Get.find<DietMenuController>();

  @override
  void initState() {
    super.initState();

    _selectedDate = dietMenuController.dietMenuSelectedDate ?? _currentDate;

    // Calculate the initial page based on the selected date
    int initialPage =
        (_selectedDate!.difference(_currentDate).inDays / 7).floor();
    _pageController = PageController(initialPage: initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCalendar(),
      ],
    );
  }

  Widget _buildCalendar() {
    return SizedBox(
      height: 75,
      child: PageView.builder(
        controller: _pageController,
        itemCount: 1000,
        itemBuilder: (context, index) {
          DateTime weekStart = _currentDate.add(Duration(days: index * 7));
          DateTime weekEnd = weekStart.add(Duration(days: 6));

          return _buildWeek(weekStart, weekEnd);
        },
      ),
    );
  }

  Widget _buildWeek(DateTime weekStart, DateTime weekEnd) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (index) {
        DateTime currentDate = weekStart.add(Duration(days: index));
        return _buildDay(currentDate);
      }),
    );
  }

  Widget _buildDay(DateTime date) {
    bool isSelected = _selectedDate != null &&
        DateFormat('yyyy-MM-dd').format(_selectedDate!) ==
            DateFormat('yyyy-MM-dd').format(date);

    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    String? dayStatus =
        calendarController.SubscriptionActiveDates[formattedDate];

    return GestureDetector(
      onTap: () {
        _handleDateSelection(date, dayStatus);
      },
      child: Column(
        children: [
          Text(
            _getWeekdayAbbreviation(date.weekday),
            style: TextStyle(
                fontWeight: FontWeight.w500, color: kLightPrimaryColor),
          ),
          Container(
            width: 30,
            height: 50,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: isSelected ? kPrimaryColor : borderColor,
              ),
              color: isSelected ? kPrimaryColor : null,
            ),
            child: Column(
              children: [
                Text(
                  date.day.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? kWhiteColor : kLightPrimaryColor,
                  ),
                ),
                if (dayStatus == "delivered")
                  Icon(Icons.check, size: 12, color: Colors.green),
                if (dayStatus == "meal-not-selected")
                  SvgPicture.asset("assets/icon/Select.svg",
                      color: isSelected ? kWhiteColor : null),
                if (dayStatus == "off-day")
                  Icon(Icons.close, size: 12, color: Colors.red),
                if (dayStatus == "freezed")
                  Icon(Icons.close, size: 12, color: Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleDateSelection(DateTime date, String? dayStatus) {
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
          _selectedDate = date;
        });
      }
    }else{
      toast("Subscription Not Active");
    }


  }

  String _getWeekdayAbbreviation(int weekday) {
    List<String> weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return weekdays[weekday % 7];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
