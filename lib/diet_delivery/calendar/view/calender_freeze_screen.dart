import 'package:diet_diet_done/auth/sign_up/widget/Clip_path.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/calendar_controller.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/diet_menu_controller.dart';
import 'package:diet_diet_done/diet_delivery/calendar/widgets/freeze_calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarFreezeScreen extends StatelessWidget {
  const CalendarFreezeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final calendarController = Get.find<CalendarController>();

    return Scaffold(
      appBar: AppBar(
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
            child: Column(
              children: [
                const Text(
                  "Freeze Schedule",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FreezeCalendarWidget(),
                  ),
                ),
                kHeight(10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size(200, 50),
                    ),
                    onPressed: () async {
                      if (calendarController.freezedSelectedDate.isEmpty) {
                        Get.snackbar("Date didn't selected",
                            "Please Select date which you have to freeze",backgroundColor: kPrimaryColor, colorText: kWhiteColor);
                      } else {
                        await calendarController.freezeCalendar();
                      }
                    },
                    child: Text(
                      "Done",
                      style: Theme.of(context).textTheme.labelLarge,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
