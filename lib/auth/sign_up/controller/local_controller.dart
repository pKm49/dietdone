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
  var profileImage = "".obs;
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

  validateArabic(String? value, message) {
    String validOtpPattern = r'[^\p{Arabic}\w\s]';
    RegExp validOtpRegex = new RegExp(validOtpPattern);

    if (value!.isEmpty || !validOtpRegex.hasMatch(value)) {
      return "Please provide an arabic name";
    }

    return null;
  }

  validate(String? value, message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  String? checkIfEmailFormValid(String? email) {
    String validOtpPattern = r'(^$)|(^.*@.*\..*$)';
    RegExp validOtpRegex = new RegExp(validOtpPattern);

    if (email!.isEmpty || !validOtpRegex.hasMatch(email)) {
      return "Please provide a valid Email";
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
    profileImage.value = base64Encode(imageBytes);
  }
}
