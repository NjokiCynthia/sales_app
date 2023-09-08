import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/strings.dart';

class MyTheme {
  static var darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryDarkColor,
    scaffoldBackgroundColor: backColor,
    dialogBackgroundColor: primaryDarkColor,
    fontFamily: Strings.fontName,
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: primaryDarkColor),
    appBarTheme:
        const AppBarTheme(backgroundColor: primaryDarkColor, elevation: 0),
  );
}

TextStyle displaySmallThinWhite = GoogleFonts.getFont(
  Strings.fontName, // Use the Strings class to get the font family
  fontSize: 12,
  fontWeight: FontWeight.w300,
  color: Colors.white,
);

TextStyle bodyText = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);
TextStyle displayTitle = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
TextStyle buttonText = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: primaryDarkColor,
);
TextStyle displaySmallWhite = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);
TextStyle displaySmallBoldLightGrey = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 10,
  fontWeight: FontWeight.bold,
  color: Colors.black.withOpacity(0.4),
);
TextStyle displaySmallerLightGrey = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 13,
  fontWeight: FontWeight.w500,
  color: Colors.black.withOpacity(0.4),
);
TextStyle displayBigBoldWhite = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 25,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
TextStyle displayBigBoldBlack = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 25,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
TextStyle displayNormalWhite = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 15,
  fontWeight: FontWeight.w300,
  color: Colors.white,
);
TextStyle displayNormalWhiteBold = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);
TextStyle displayGrey = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: Colors.grey,
);
