import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSocialButton extends StatelessWidget {
  CustomSocialButton(
      {super.key,
      required this.size,
      required this.imageUrl,
      this.onTap,
      required this.color});

  final Size size;
  final String imageUrl;
  void Function()? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.width * 0.13,
      width: size.width * 0.25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color)),
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: SvgPicture.asset(imageUrl),
      ),
    );
  }
}
