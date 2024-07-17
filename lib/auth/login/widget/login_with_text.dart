import 'package:diet_diet_done/core/constraints/const_colors.dart';
import 'package:flutter/material.dart';

class LoginWithText extends StatelessWidget {
  const LoginWithText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: kWhiteColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Or Login with",
            style: TextStyle(color: kWhiteColor),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: kWhiteColor,
          ),
        ),
      ],
    );
  }
}
