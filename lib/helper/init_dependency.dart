import 'package:diet_diet_done/auth/login/controller/login_controller.dart';
import 'package:diet_diet_done/auth/sign_up/controller/area_&_block_controller.dart';
import 'package:diet_diet_done/auth/sign_up/controller/local_controller.dart';
import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/auth/sign_up/firebase/sign_up_using_firebase.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/calendar_controller.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/diet_menu_controller.dart';
import 'package:diet_diet_done/diet_delivery/home/controller/bottom_nav_controller.dart';
import 'package:diet_diet_done/diet_delivery/home/controller/getProfileController.dart';
import 'package:diet_diet_done/diet_delivery/home/controller/home_screen_controller.dart';
import 'package:diet_diet_done/food_delivery/menu/controller/Menu_controller.dart';
import 'package:diet_diet_done/profile/controller/Profile_controller.dart';
import 'package:diet_diet_done/profile_config/controller/address_controller.dart';
import 'package:diet_diet_done/profile_config/controller/coupon_controller.dart';
import 'package:diet_diet_done/profile_config/controller/plan_categories_controller.dart';
import 'package:diet_diet_done/profile_config/controller/profile_config_controller.dart';
import 'package:diet_diet_done/profile_config/controller/subscription_plan_controller.dart';
import 'package:get/get.dart';

class InitDependency extends Bindings {
  @override
  void dependencies() {
    Get.put(AreaAndBlockController());
    Get.put(LocalController());
    Get.put(SignUpController());
    Get.put(AddressController());
    Get.put(ProfileConfigController());
    Get.put(SignUpUsingFirebaseController());
    Get.put(HomeController());
    Get.put(BottomNavController());
    Get.put(LoginController());
    Get.put(MenusController());
    Get.put(ProfileController());
    Get.put(PlanCategoriesController());
    Get.put(GetProfileController());
    Get.put(SubscriptionPlanController());
    Get.put(CouponController());
    Get.put(CalendarController());
    Get.put(DietMenuController());
  }
}
