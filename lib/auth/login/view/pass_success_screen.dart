import 'package:diet_diet_done/auth/login/view/login_screen.dart';
import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PassChangedSuccessScreen extends StatelessWidget {
  PassChangedSuccessScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.10,
              width: size.height * 0.10,
              child: Image.asset(
                "assets/illustrations/Successmark.png",
              ),
            ),
            kHeight(20),
            Text(
              "OTP Verification",
              style: theme.textTheme.titleMedium,
            ),
            kHeight(10),
            const Text(
              "Your password has been changed\nsuccessfully.",
              textAlign: TextAlign.center,
            ),
            kHeight(20),
            ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.clear();

                  Get.offAll(LoginScreen());
                },
                style: ElevatedButton.styleFrom(backgroundColor: kBlackColor),
                child: Text(
                  "Back to Login",
                  style: theme.textTheme.labelLarge,
                )),
          ],
        ),
      ),
    );
  }
}
