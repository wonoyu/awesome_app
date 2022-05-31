import 'package:awesome_app/src/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final themeData = _buildAppTheme();

ThemeData _buildAppTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: ColorConstants.primaryColor,
      primaryContainer: ColorConstants.primaryContainer,
      onPrimary: ColorConstants.onPrimary,
      secondary: ColorConstants.secondaryColor,
      secondaryContainer: ColorConstants.secondaryContainer,
      onSecondary: ColorConstants.onSecondary,
      tertiary: ColorConstants.tertiaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: base.textTheme.labelMedium!.apply(
        fontFamily: GoogleFonts.josefinSans().fontFamily,
      ),
      fillColor: ColorConstants.onPrimary,
      focusColor: ColorConstants.onPrimary,
      iconColor: ColorConstants.onPrimary,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2.0,
          color: ColorConstants.onPrimary,
        ),
      ),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2.0,
          color: ColorConstants.onPrimary,
        ),
      ),
    ),
    textTheme: _buildAppTextTheme(base.textTheme),
  );
}

TextTheme _buildAppTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline5: base.headline5!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        headline6: base.headline6!.copyWith(
          fontSize: 18.0,
        ),
        caption: base.caption!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyText1: base.bodyText1!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: GoogleFonts.josefinSans().fontFamily,
        displayColor: ColorConstants.onPrimary,
        bodyColor: ColorConstants.onPrimary,
      );
}
