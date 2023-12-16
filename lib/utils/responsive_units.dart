import 'package:flutter/material.dart';

extension Responsive on BuildContext {
  // responsive width
  double screenWidth(double fraction) {
    return MediaQuery.sizeOf(this).width * fraction;
  }

  // responsive height
  double screenHeight(double fraction) {
    return MediaQuery.sizeOf(this).height * fraction;
  }
}
