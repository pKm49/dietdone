import 'dart:developer';

import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/profile/api/update_allergies.dart';
import 'package:diet_diet_done/profile/controller/Profile_controller.dart';
import 'package:diet_diet_done/profile/model/allergies_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

class AllergiesScreen extends StatelessWidget {
  AllergiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.find<ProfileController>();
    final theme = Theme.of(context);

    final TextEditingController searchController = TextEditingController();
    final Rx<String> searchQuery = "".obs;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 41,
                        height: 41,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: borderColor,
                          ),
                          color: kWhiteColor,
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                    ),
                    controller.isShowSearch == false
                        ? Text(
                            "Allergies",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        : Expanded(
                            child: TextFormField(
                              controller: searchController,
                              onChanged: (value) {
                                searchQuery.value = value;
                              },
                              decoration: InputDecoration(
                                fillColor: kWhiteColor,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                hintText: "Search",
                              ),
                            ),
                          ),
                    IconButton(
                      onPressed: () {
                        controller.isShowSearch.toggle();
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.grey[300],
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
              Obx(
                () {
                  List<AllergiesModel> filteredAllergiesList = controller
                      .allergiesList
                      .where((allergy) => allergy.name
                          .toLowerCase()
                          .contains(searchQuery.value.toLowerCase()))
                      .toList();

                  return Container(
                    height: size.height * 0.40,
                    child: controller.allergiesList.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              for (AllergiesModel allergy
                                  in filteredAllergiesList)
                                buildCheckBox(allergy, controller)
                            ],
                          ),
                  );
                },
              ),
              Text(
                "Scroll down for more..",
                style: TextStyle(color: Colors.amber),
              ),
              const Divider(),
              kHeight(10),
              Container(
                padding: const EdgeInsets.all(10),
                height: 200,
                width: size.width,
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 208, 208, 208)
                          .withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Obx(() {
                  final List<String> selectedNames = controller.selectedOptions
                      .map((element) => element.name)
                      .toList();
                  return Text("Selected Options: ${selectedNames.join(", ")}");
                }),
              ),
              kHeight(30),
              ElevatedButton(
                onPressed: () async {
                  List selectedOptionIds = controller.submitSelectedOptions();
                  if (selectedOptionIds.isEmpty) {
                    Get.snackbar(
                      "Select Your Ingredient",
                      "Please select at least one ingredient before updating.",backgroundColor: kPrimaryColor, colorText: kWhiteColor
                    );
                  } else {
                    toast("Loading.....");
                    log(selectedOptionIds.toString());
                    await UpdateAllergiesAPiServices()
                        .updateAllergies(selectedOptionIds);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: kBlackColor),
                child: Text(
                  "Done",
                  style: theme.textTheme.labelLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildCheckBox(AllergiesModel option, ProfileController controller) {
  return Row(
    children: [
      Column(
        children: [
          Text(
            option.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          kHeight(10),
        ],
      ),
      const Spacer(),
      Obx(
        () => InkWell(
          onTap: () {
            controller.toggleOption(option);
          },
          child: controller.selectedOptions.map((element) => element.id).toList().contains(option.id)
              ? const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.amber,
                )
              : const Icon(Icons.circle_outlined, color: Colors.amber),
        ),
      ),
    ],
  );
}
