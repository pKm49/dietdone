import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constraints/const_colors.dart';

class CurvedClipPath extends StatelessWidget {
  const CurvedClipPath({super.key, required this.size, required this.color});

  final Size size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipPath(),
      child: Container(
        decoration: BoxDecoration(color: color, boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3))
        ]),
        height: size.height * 0.15,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Center(
            child: Text(
              "Sign Up".tr,
              style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: kWhiteColor),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(0, size.height * 0.25);
    path_0.quadraticBezierTo(size.width * 0.2680000, size.height * 0.8165000,
        size.width * 0.5000000, size.height * 0.8000000);
    path_0.quadraticBezierTo(size.width * 0.7332500, size.height * 0.8065000,
        size.width, size.height * 0.25);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(0, 0);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
