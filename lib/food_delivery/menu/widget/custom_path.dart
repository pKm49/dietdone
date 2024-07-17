import 'package:flutter/material.dart';

class CustomPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0008333, size.height * 0.0007143);
    path_0.lineTo(0, size.height * 0.7142857);
    path_0.quadraticBezierTo(size.width * 0.1625000, size.height,
        size.width * 0.5000000, size.height * 1.0007143);
    path_0.quadraticBezierTo(size.width * 0.8325000, size.height * 1.0014286,
        size.width, size.height * 0.7142857);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width * 0.0008333, size.height * 0.0007143);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
