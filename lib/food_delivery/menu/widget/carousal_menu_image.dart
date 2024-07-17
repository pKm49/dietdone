import 'package:carousel_slider/carousel_slider.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:diet_diet_done/food_delivery/menu/controller/Menu_controller.dart';
import 'package:diet_diet_done/food_delivery/menu/model/meals_by_id_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CarousalMenuImage extends StatelessWidget {
  const CarousalMenuImage({
    super.key,
    required this.size,
    required this.mealsList,
    required this.controller,
  });

  final Size size;
  final MealsByIdModel mealsList;
  final MenusController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipPath(
          clipper: CustomPath(),
          child: Container(
              width: size.width,
              color: kLightPrimaryColor,
              child: Column(
                children: [
                  CarouselSlider(
                      items: [
                        mealsList.image,
                        mealsList.image,
                        mealsList.image,
                      ]
                          .map((i) => SizedBox(
                                height: size.height * 0.26,
                                width: size.height * 0.26,
                                child: Image.network(i),
                              ))
                          .toList(),
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        onScrolled: (value) {
                          controller.updateIndex(value);
                        },
                      ))
                ],
              )),
        ),
        kHeight(10),
        GetBuilder<MenusController>(
          builder: (controller) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 5,
                backgroundColor: controller.productImageIndex == 0.0
                    ? kBlackColor
                    : Colors.grey[300],
              ),
              kWidth(5),
              CircleAvatar(
                radius: 5,
                backgroundColor: controller.productImageIndex == 1.0
                    ? kBlackColor
                    : Colors.grey[300],
              ),
              kWidth(5),
              CircleAvatar(
                radius: 5,
                backgroundColor: controller.productImageIndex == 2.0
                    ? kBlackColor
                    : Colors.grey[300],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0008333, size.height * 0.0007143);
    path_0.lineTo(0, size.height * 0.7142857);
    path_0.quadraticBezierTo(size.width * 0.1625000, size.height,
        size.width * 0.5000000, size.height * 1.0007143);
    path_0.quadraticBezierTo(size.width * 0.8325000, size.height * 1.0014286,
        size.width, size.height * 0.7142857);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width * 0.0008333, size.height * 0.0007143);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
