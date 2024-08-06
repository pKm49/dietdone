import 'package:diet_diet_done/auth/login/api/login_services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool isPasswordVisible = true.obs;
  final storage = FlutterSecureStorage();
  String? accessToken;

  validateNumber(String? number) {
    if (number == null || number.isEmpty) {
      return "Phone number is empty";
    }
    return null;
  }

  validatePassword(String? pass) {
    if (pass == null || pass.isEmpty) {
      return "Password is empty";
    }
    return null;
  }

  Future onLogin() async {
    if (formKey.currentState!.validate()) {
      await LoginApiService().userLogin();
      // dispose();
      return;
    }
  }

  @override
  void dispose() {
    phoneNumberController.clear();
    passwordController.clear();
    super.dispose();
  }
}
