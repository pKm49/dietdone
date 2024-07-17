import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarTitleWithBackButtonAndTitle extends StatelessWidget {
  const AppBarTitleWithBackButtonAndTitle({
    super.key,
    required this.size,
    required this.title,
  });

  final Size size;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
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
        kWidth(size.width * 0.25),
        Text(title),
      ],
    );
  }
}
