import 'package:diet_diet_done/auth/sign_up/controller/local_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({super.key, required this.value, required this.title});

  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalController>(
      builder: (controller) {
        return InkWell(
          onTap: () {},
          child: Radio(
              value: value,
              groupValue: controller.selectedValueSource.value,
              onChanged: (value) => controller.selectedValueSource),
        );
      },
    );
  }
}
