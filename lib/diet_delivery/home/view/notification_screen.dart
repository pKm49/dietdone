import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/diet_delivery/home/controller/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key, required this.homeController});

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeController.fetchNotification();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: homeController.notificationList.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notification_important_sharp,
                      size: 50,
                    ),
                    kHeight(20),
                    Text("Currently you don't have any notification")
                  ],
                ),
              )
            : Obx(
                () => ListView.builder(
                    itemCount: homeController.notificationList.length,
                    itemBuilder: (context, index) {
                      final notificationList =
                          homeController.notificationList[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(notificationList.image),
                              ),
                              kWidth(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notificationList.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  Text(notificationList.message)
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
      ),
    );
  }
}
