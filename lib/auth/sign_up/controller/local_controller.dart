import 'dart:convert';

import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class LocalController extends GetxController {
  RxInt selectedValueSource = 1.obs;
  RxString source = "Social media".obs;
  RxBool termsAndCondition = true.obs;
  File? selectedImage;
  String? profileImage;
  void selectValue(int value) {
    selectedValueSource.value = value;
  }

  Country selectedCountry = Country(
    phoneCode: "965",
    countryCode: "KW",
    e164Sc: 965,
    geographic: true,
    level: 1,
    name: "Kuwait",
    example: "Kuwait",
    displayName: "Kuwait",
    displayNameNoCountryCode: "KW",
    e164Key: "965",
  );

  changeCountry(value) {
    selectedCountry = value;
    update();
  }

  void changeLanguage(var params1, var params2) {
    var local = Locale(params1, params2);
    Get.updateLocale(local);
  }

  validate(String? value, message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;

    selectedImage = File(returnedImage.path);
    update();
  }

  imageToBase64() {
    List<int> imageBytes = selectedImage!.readAsBytesSync();
    profileImage = base64Encode(imageBytes);
  }
}
