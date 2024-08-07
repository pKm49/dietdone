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
      profile_picture: localController.profileImage.value,
       other_source: otherSourceController.text,
    ));
    dispose();
  }

  Future updateUserProfile(mobile, lastName, name, email,profilePicture) async {
    await SignUpApiServices().UpdateUserProfile(mobile, lastName, name, email,profilePicture);

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
