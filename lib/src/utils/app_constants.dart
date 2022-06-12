import 'package:flutter/material.dart';

class AppConstants {
  static Size getSize(BuildContext context) => MediaQuery.of(context).size;
  static ThemeData getTheme(BuildContext context) => Theme.of(context);
  static const paddingSize = 24.0;
  static const imageTest =
      "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800";
  static const apiKey =
      "563492ad6f917000010000017239aebdd8654de3bb71b203cf1c153c ";
  static const baseUrl = "api.pexels.com";
  static const curatedUrl = "/v1/curated";
}

class ColorConstants {
  static const primaryColor = Color(0xFFFFAFCC);
  static const primaryContainer = Color(0xFFFFC8DD);
  static const secondaryColor = Color(0xFFA2D2FF);
  static const secondaryContainer = Color(0xFFBDE0FE);
  static const onPrimary = Colors.black;
  static const onSecondary = Colors.black;
  static const tertiaryColor = Color(0xFFCDB4DB);
  static const primaryAlternative = Color(0xFFFFA8DC);
  static const primaryAlternative2 = Color(0xFFF66DB5);
}

class AssetConstants {
  static const appbarImg = "assets/images/appbar_img2.jpg";
  static const loadingImg = "assets/images/logo.png";
  static const noImg = "assets/images/no_image.png";
  static const notConnectedImg = "assets/images/not_connected.png";
}
