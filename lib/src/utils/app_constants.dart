import 'package:flutter/material.dart';

class AppConstants {
  static Size getSize(BuildContext context) => MediaQuery.of(context).size;
  static ThemeData getTheme(BuildContext context) => Theme.of(context);
  static const paddingSize = 24.0;
}

class ColorConstants {
  static const primaryColor = Color(0xFFFFAFCC);
  static const primaryContainer = Color(0xFFFFC8DD);
  static const secondaryColor = Color(0xFFA2D2FF);
  static const secondaryContainer = Color(0xFFBDE0FE);
  static const onPrimary = Colors.black;
  static const onSecondary = Colors.black;
  static const tertiaryColor = Color(0xFFCDB4DB);
}

class AssetConstants {
  static const appbarImg = "assets/images/appbar_img2.jpg";
}
