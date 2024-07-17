import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/profile/controller/Profile_controller.dart';
import 'package:diet_diet_done/profile/widgets/custom_app_bar.dart';
import 'package:diet_diet_done/profile/widgets/custom_divider.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SubscriptionDetailScreen extends StatelessWidget {
  const SubscriptionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        profileController.fetchSubsHistory();
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomAppBar(title: "Subscription"),
              ),
              kHeight(20),
              profileController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: profileController.subsHistoryList.isEmpty
                          ? Text("No subscriptions history available")
                          : ListView.separated(
                              itemCount:
                                  profileController.subsHistoryList.length,
                              itemBuilder: (BuildContext context, int index) {
                                final subsHistory =
                                    profileController.subsHistoryList[index];
                                final formattedDate = DateFormat("MMMM d")
                                    .format(subsHistory.startDate);
                                final endFormattedDate = DateFormat("MMMM d")
                                    .format(subsHistory.endDate);
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: kWhiteColor,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color.fromARGB(
                                                  255, 208, 208, 208)
                                              .withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          profileController
                                              .subsHistoryList[index].plan,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Divider(
                                          color: const Color.fromARGB(
                                              255, 231, 231, 231),
                                        ),
                                        kHeight(5),
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: List.generate(
                                            subsHistory.mealsConfig.length,
                                            (index) => IntrinsicWidth(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 10),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      subsHistory
                                                          .mealsConfig[index]
                                                          .name,
                                                      // style: TextStyle(fontSize: 16),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: kPrimaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 6.0,
                                                          horizontal: 10.0),
                                                      child: Text(
                                                        subsHistory
                                                            .mealsConfig[index]
                                                            .itemCount
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        kHeight(5),
                                        DividerWithGap(),
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_month),
                                            kWidth(5),
                                            Text(
                                              "$formattedDate to $endFormattedDate ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 17),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      kHeight(10)),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
