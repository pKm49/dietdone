import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/diet_delivery/calendar/controller/calendar_controller.dart';
import 'package:diet_diet_done/food_delivery/menu/model/meals_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:overlay_support/overlay_support.dart';

class CustomMenuCard extends StatelessWidget {
  const CustomMenuCard(
      {super.key,
      required this.size,
      required this.onTap,
      this.mealsModel,
      required this.calendarController});

  final Size size;
  final void Function()? onTap;
  final MealsModel? mealsModel;
  final CalendarController calendarController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 240, 240, 240),
                        borderRadius: BorderRadius.circular(15)),
                    height: size.height * 0.25,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Text(
                                  maxLines: 2,
                                  mealsModel!.name,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber,
                              ),
                              kWidth(5),
                              Text(mealsModel!.rating),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${mealsModel!.price}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  InkWell(
                                    child: Container(
                                      height: 18,
                                      width: 18,
                                      decoration: BoxDecoration(
                                          color: kBlackColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2))),
                                      child: Icon(
                                        Icons.remove,
                                        color: kWhiteColor,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => IconButton(
                                        onPressed: () {
                                          // Get.to(CartScreen());

                                          if (calendarController
                                                  .mealsSelectionCount ==
                                              0) {
                                            calendarController
                                                .selectedMealsListCount
                                                .add(mealsModel!.id);
                                            calendarController
                                                .mealsSelectionCount.value++;
                                          } else if (calendarController
                                                  .mealsSelectionCount ==
                                              1) {
                                            calendarController
                                                .mealsSelectionCount--;
                                            calendarController
                                                .selectedMealsListCount
                                                .remove(mealsModel!.id);
                                          } else {
                                            toast("Your Limit reached");
                                          }
                                        },
                                        icon: calendarController
                                                        .mealsSelectionCount ==
                                                    1 &&
                                                calendarController
                                                    .selectedMealsListCount
                                                    .contains(mealsModel!.id)
                                            ? Icon(
                                                Icons.check_box,
                                              )
                                            : Icon(
                                                Icons.add_box_rounded,
                                                color: kBlackColor,
                                              )),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: Image.network(mealsModel!.image).image,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
