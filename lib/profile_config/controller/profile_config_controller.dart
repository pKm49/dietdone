import 'package:diet_diet_done/profile_config/controller/address_controller.dart';
import 'package:diet_diet_done/profile_config/view/about_me_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileConfigController extends GetxController {
  bool isGenderSelected = false;
  final formKey = GlobalKey<FormState>();
  final testController = TextEditingController();

  final addressController = Get.find<AddressController>();
  validate(String? value, message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  validation() {
    if (formKey.currentState!.validate()) {
      // addressController.createAddress();
      Get.to(AboutMeScreen());
    }
  }
}
