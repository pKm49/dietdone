import 'dart:developer';
import 'package:diet_diet_done/auth/sign_up/api/sign_up_api_service.dart';
import 'package:diet_diet_done/auth/sign_up/controller/area_&_block_controller.dart';
import 'package:diet_diet_done/auth/sign_up/controller/local_controller.dart';
import 'package:diet_diet_done/auth/sign_up/firebase/sign_up_using_firebase.dart';
import 'package:diet_diet_done/auth/sign_up/model/create_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends GetxController {
  final englishKey = GlobalKey<FormState>();
  final arabicKey = GlobalKey<FormState>();
  final numberKey = GlobalKey<FormState>();
  final localController = Get.find<LocalController>();
  RxString? verificationFIrebaseID;
  bool termsAndConditions = false;
  int height = 154;
  int weight = 70;
  String source = "social";
  RxBool showOtherTextField = false.obs;
  String gender = "male";
  final formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController forgetPasswordOtpController =
      TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController englishFirstName = TextEditingController();
  final TextEditingController englishLastName = TextEditingController();
  final TextEditingController arabicLastName = TextEditingController();
  final TextEditingController arabicFirstName = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController blockController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController jedahController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController floorNoController = TextEditingController();
  TextEditingController flatNoController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController otherSourceController = TextEditingController();
  int? areaId;
  int? blockName;
  String? mobileNumber;

  String uid = "";

  validate(String value, String message) {
    if (formKey.currentState!.validate()) {
      return message;
    }
  }

  saveMobileNumber() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    mobileNumber = preferences.getString("mobile")!;
  }

  sendNumber() {
    final fireBaseController = Get.find<SignUpUsingFirebaseController>();
    fireBaseController.signUpWithPhoneNumber(
      "+${localController.selectedCountry.phoneCode}${phoneNumberController.text}",
    );
  }

  sendOTP(verificationId) {
    final signUpController = Get.find<SignUpController>();
    final fireBaseController = Get.find<SignUpUsingFirebaseController>();
    fireBaseController.verifyOtp(
        userOtp: signUpController.otpController.text,
        verificationId: verificationId);
  }




  Future<void> onSignUp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("mobile", phoneNumberController.text);
    log("Height:${heightController.text}\nWeight:${weightController.text}",
        name: "Changed height and weight");

    String? jedhaValue = jedahController.text.isNotEmpty
        ? jedahController.text.trim()
        : "Default Jedha";
    int houseNumberValue = houseNumberController.text.isNotEmpty
        ? int.parse(houseNumberController.text.trim())
        : 1;
    int floorNumberValue = floorNoController.text.isNotEmpty
        ? int.parse(floorNoController.text.trim())
        : 2;
    String commentsValue = commentsController.text.isNotEmpty
        ? commentsController.text.trim()
        : "Default Comment";

    await SignUpApiServices().createNewProfile(CreateProfileModel(
      mobile: phoneNumberController.text,
      password: passwordController.text,
      firstName: englishFirstName.text.trim(),
      lastName: englishLastName.text.trim(),
      firstNameArabic: arabicFirstName.text.trim(),
      lastNameArabic: arabicLastName.text.trim(),
      email: emailController.text.trim(),
      dateOfBirth: "1999-02-03",
      gender: gender,
      height: double.parse(heightController.text),
      weight: double.parse(weightController.text),
      source: source,
      nickname: "House",
      area: areaId!,
      block: blockName!,
      street: streetController.text.trim(),
      jedha: jedhaValue,
      houseNumber: houseNumberValue,
      floorNumber: floorNumberValue,
      comments: commentsValue,
      profile_picture: localController.profileImage ??
          "/9j/4AAQSkZJRgABAQEBLAEsAAD/4QBWRXhpZgAATU0AKgAAAAgABAEaAAUAAAABAAAAPgEbAAUAAAABAAAARgEoAAMAAAABAAIAAAITAAMAAAABAAEAAAAAAAAAAAEsAAAAAQAAASwAAAAB/+0ALFBob3Rvc2hvcCAzLjAAOEJJTQQEAAAAAAAPHAFaAAMbJUccAQAAAgAEAP/hDIFodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvADw/eHBhY2tldCBiZWdpbj0n77u/JyBpZD0nVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkJz8+Cjx4OnhtcG1ldGEgeG1sbnM6eD0nYWRvYmU6bnM6bWV0YS8nIHg6eG1wdGs9J0ltYWdlOjpFeGlmVG9vbCAxMC4xMCc+CjxyZGY6UkRGIHhtbG5zOnJkZj0naHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyc+CgogPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9JycKICB4bWxuczp0aWZmPSdodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyc+CiAgPHRpZmY6UmVzb2x1dGlvblVuaXQ+MjwvdGlmZjpSZXNvbHV0aW9uVW5pdD4KICA8dGlmZjpYUmVzb2x1dGlvbj4zMDAvMTwvdGlmZjpYUmVzb2x1dGlvbj4KICA8dGlmZjpZUmVzb2x1dGlvbj4zMDAvMTwvdGlmZjpZUmVzb2x1dGlvbj4KIDwvcmRmOkRlc2NyaXB0aW9uPgoKIDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PScnCiAgeG1sbnM6eG1wTU09J2h0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8nPgogIDx4bXBNTTpEb2N1bWVudElEPmFkb2JlOmRvY2lkOnN0b2NrOjM4M2E5YmJhLWJjMTEtNDM2NS04MmU2LTcwZDUxMTNlYzhhNzwveG1wTU06RG9jdW1lbnRJRD4KICA8eG1wTU06SW5zdGFuY2VJRD54bXAuaWlkOmYwOWNlMTZlLTU5YTItNDFiOC1iMDNhLWUzNzAwY2IzYzc2YzwveG1wTU06SW5zdGFuY2VJRD4KIDwvcmRmOkRlc2NyaXB0aW9uPgo8L3JkZjpSREY+CjwveDp4bXBtZXRhPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAo8P3hwYWNrZXQgZW5kPSd3Jz8+/9sAQwAFAwQEBAMFBAQEBQUFBgcMCAcHBwcPCwsJDBEPEhIRDxERExYcFxMUGhURERghGBodHR8fHxMXIiQiHiQcHh8e/9sAQwEFBQUHBgcOCAgOHhQRFB4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4e/8AAEQgBaAFoAwERAAIRAQMRAf/EABsAAQACAwEBAAAAAAAAAAAAAAACBQMEBgEI/8QANRABAAIBAgQDBgUEAQUAAAAAAAECAwQRBRIhMSJRYRMyQXGR0SMzUmKBU3KhwZIUFUKC4f/E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",
      other_source: otherSourceController.text,
    ));
    dispose();
  }

  Future updateUserProfile(mobile, lastName, name, email) async {
    await SignUpApiServices().UpdateUserProfile(mobile, lastName, name, email);

  }

  Future checkUserLogin() async {
    await SignUpApiServices()
        .checkUserLogged(mobileNumber, passwordController.text);
  }

  @override
  void dispose() {
    passwordController.clear();
    confirmPassController.clear();
    englishFirstName.clear();
    englishLastName.clear();
    arabicLastName.clear();
    phoneNumberController.clear();
    otpController.clear();
    areaController.clear();
    blockController.clear();
    streetController.clear();
    jedahController.clear();
    houseNumberController.clear();
    floorNoController.clear();
    flatNoController.clear();
    commentsController.clear();
    emailController.clear();
    super.dispose();
  }
}
