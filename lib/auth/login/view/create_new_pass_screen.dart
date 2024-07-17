import 'package:diet_diet_done/auth/login/api/reset_password_service.dart';
import 'package:diet_diet_done/auth/sign_up/controller/sign_up_controller.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewPassScreen extends StatelessWidget {
  CreateNewPassScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final signUpController = Get.find<SignUpController>();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create new password",
                style: theme.textTheme.titleMedium,
              ),
              kHeight(10),
              const Text(
                  "Your new password must be unique from those previously used."),
              kHeight(50),
              TextFormField(
                obscureText: true,
                controller: signUpController.newPasswordController,
                decoration: const InputDecoration(hintText: "New Password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your new password";
                  } else {
                    return null;
                  }
                },
              ),
              kHeight(10),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(hintText: "Confirm Password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your confirm password";
                  }
                  if (value != signUpController.newPasswordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
              kHeight(20),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await ResetPasswordApiService().resetPassword();
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: kBlackColor),
                  child: Text(
                    "Reset Password",
                    style: theme.textTheme.labelLarge,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
