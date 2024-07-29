import 'dart:developer';

import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/diet_delivery/calendar/api/get_calendar_dates_service.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/diet_menu_controller.dart';
import 'package:diet_diet_done/diet_delivery/home/api/get_support_service.dart';
import 'package:diet_diet_done/diet_delivery/home/api/pass_device_token.dart';
import 'package:diet_diet_done/diet_delivery/home/controller/getProfileController.dart';
import 'package:diet_diet_done/diet_delivery/home/controller/home_screen_controller.dart';
import 'package:diet_diet_done/diet_delivery/home/widgets/custom_app_bar.dart';
import 'package:diet_diet_done/diet_delivery/home/widgets/custom_elevated_button.dart';
import 'package:diet_diet_done/diet_delivery/home/widgets/floating_action_button.dart';
import 'package:diet_diet_done/diet_delivery/home/widgets/profile_card_image.dart';
import 'package:diet_diet_done/diet_delivery/home/widgets/profile_diet_card.dart';
import 'package:diet_diet_done/food_delivery/menu/api/show_menu_api_service.dart';
import 'package:diet_diet_done/profile_config/api_service/appointment_booking_service.dart';
import 'package:diet_diet_done/profile_config/controller/subscription_plan_controller.dart';
import 'package:diet_diet_done/profile_config/view/plan_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    checkNotificationsPermission();
    final PassDeviceTokenToBackEnd passDeviceTokenToBackEnd =
        PassDeviceTokenToBackEnd();
    final getProfileController = Get.find<GetProfileController>();
    final homeScreenController = Get.find<HomeController>();
    final subscriptionController = Get.find<SubscriptionPlanController>();
    final calendarController = Get.find<DietMenuController>();

    await Future.wait<void>([
      getProfileController.fetchProfileData(),
      subscriptionController.getSubscriptionDetails(),
      GetCalendarDatesApiService().getCalendarDates(),
      homeScreenController.fetchNotification(),
      ShowMenuApiService().showMenu(),
      calendarController.fetchDietMeals(),
      GetSupportNumberApiService().getSupportNumber(),
      passDeviceTokenToBackEnd.sendDeviceToken(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final subscriptionController = Get.find<SubscriptionPlanController>();
    final homeScreenController = Get.find<HomeController>();
    final getProfileController = Get.find<GetProfileController>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
            child: Image.asset(
          "assets/background_image/pexels-oziel-gвmez-16674273.jpg",
          fit: BoxFit.cover,
        )),
        Container(
          color: Colors.black.withOpacity(0.6),
        ),
        CustomAppBarTile(
          size: size,
          profileController: getProfileController,
          homeController: homeScreenController,
        ),
        Container(
          child: LayoutBuilder(
            builder: (context, constraints) => Stack(
              children: [
                Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      subscriptionController.isLoading.value
                          ? ProfileDietCardShimmer()
                          : subscriptionController.subscriptionDetails.isEmpty
                              ? Center(
                                  child: Container(
                                    height: 250,
                                    width: 250,
                                    decoration: BoxDecoration(
                                        color: kWhiteColor.withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                      child: Text(
                                        "Your subscription is not\nyet activated",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: kWhiteColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                )
                              : ProfileDIetCard(
                                  size: size,
                                  profileController: getProfileController,
                                  subscriptionController:
                                      subscriptionController,
                                ),
                      kHeight(5),
                      ElevatedButton2(
                        size: size,
                        backgroundColor: kWhiteColor,
                        textColor: kPrimaryColor,
                        text: "Subscription renewal",
                        onPressed: () => Get.to(PlanSelectionScreen()),
                      ),
                      kHeight(5),
                      ElevatedButton2(
                        size: size,
                        backgroundColor: kPrimaryColor,
                        textColor: kWhiteColor,
                        text: 'Book appointment',
                        onPressed: () async {
                          Get.dialog(AlertDialog(
                            title: const Text("Book a Dietician?"),
                            content: const Text(
                                "You can request a consultation by pressing yes. Our representative will contact you soon."),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    log("appointmentBooking pressed", name:"appointment");
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
                          ));
                        },
                      )
                    ],
                  ),
                ),
                ProfileCardImage(
                  size: size,
                  profileController: getProfileController,
                ),
                const CustomFloatingActionButton()
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Future<void> checkNotificationsPermission() async {
    await Permission.notification.isDenied.then((value) async {
      if (value) {
        if(!await getPermissionRequestSharedPreference()){
          showPermissionDialogue();
        }
      }
    });
  }

  void showPermissionDialogue( ) async {
    setPermissionRequestSharedPreference();

    final dialogTitleWidget = Text('notification_access_permission_title'.tr);
    final dialogTextWidget = Text( 'notification_access_permission_info'.tr );

    final updateButtonTextWidget = Text('continue'.tr,style: TextStyle(color: kWhiteColor),);

    updateAction() {
      Navigator.pop(context);
      Permission.notification.request();
    }

    List<Widget> actions = [


      ElevatedButton(
          onPressed:updateAction,
          child:  updateButtonTextWidget)
    ];

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            child:AlertDialog(
              title: dialogTitleWidget,
              content: dialogTextWidget,
              actions: actions,
            ),
            onWillPop: () => Future.value(false));
      },
    );
  }

  Future<bool> getPermissionRequestSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isNotificationPermissionAsked = prefs.getBool('isNotificationPermissionAsked');
    print("getPermissionRequestSharedPreference");
    print(isNotificationPermissionAsked);
    return isNotificationPermissionAsked !=null?isNotificationPermissionAsked:false;
  }

  Future<void> setPermissionRequestSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isNotificationPermissionAsked',true);
  }


}

class ProfileDietCardShimmer extends StatelessWidget {
  const ProfileDietCardShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 250,
        width: 250,
        child: Shimmer.fromColors(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(20)),
            ),
            baseColor: Colors.grey,
            highlightColor: kWhiteColor),
      ),
    );
  }
}
