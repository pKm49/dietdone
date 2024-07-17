import 'package:diet_diet_done/auth/login/controller/login_controller.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
  });

  final LoginController controller;
  final BorderSide borderSide = const BorderSide();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.passwordController,
      validator: (password) => controller.validatePassword(password),
      decoration: InputDecoration(
        hintText: "Enter your password",
        suffixIcon: IconButton(
            onPressed: () {}, icon: const Icon(Icons.remove_red_eye_outlined)),
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), borderSide: borderSide),
        fillColor: kWhiteColor,
        filled: true,
      ),
    );
  }
}
