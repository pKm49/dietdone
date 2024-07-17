import 'dart:developer';

import 'package:diet_diet_done/diet_delivery/home/api/get_notification_service.dart';
import 'package:diet_diet_done/diet_delivery/home/model/notification_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt tabBarIdx = 0.obs;
  RxList<NotificationModel> notificationList = <NotificationModel>[].obs;

  @override
  void onInit() {
    GetNotificationApiService().fetchNotification();
    super.onInit();
  }

  Future<void> fetchNotification() async {
    try {
      final notifications =
          await GetNotificationApiService().fetchNotification();
      notificationList.value = notifications;
      log(notificationList.toString(), name: "notification List");
    } catch (e) {
      log("error while fetching notification $e");
    }
  }
}
