import 'package:diet_diet_done/auth/login/widget/social_button.dart';
import 'package:flutter/material.dart';

class SocialMediaLogin extends StatelessWidget {
  const SocialMediaLogin({
    super.key,
    required this.size,
    required this.color,
    required this.appleLogoImageUrl,
  });

  final Size size;
  final Color color;
  final String appleLogoImageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomSocialButton(
            size: size, imageUrl: 'assets/logo/facebook_ic.svg', color: color),
        GestureDetector(
          onTap: () async {},
          child: CustomSocialButton(
            size: size,
            imageUrl: "assets/logo/google_ic.svg",
            color: color,
          ),
        ),
        CustomSocialButton(
            color: color, size: size, imageUrl: appleLogoImageUrl)
      ],
    );
  }
}
