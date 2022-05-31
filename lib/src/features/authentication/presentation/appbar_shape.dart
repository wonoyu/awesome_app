import 'package:flutter/material.dart';

class AppbarShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    Path path = Path();
    path.lineTo(0, height);
    path.quadraticBezierTo(50, height - 50, width * 0.65, height - 50);
    path.quadraticBezierTo(width * 0.80, height - 50, width, height - 120);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
