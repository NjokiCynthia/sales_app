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
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
    ),
  );
}

TextStyle bodyText = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);
TextStyle bodyTextSmall = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 14,
  fontWeight: FontWeight.w300,
  color: Colors.black,
);
TextStyle bodyGrey = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
TextStyle bodyGrey1 = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.grey,
);
TextStyle greyT = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 14,
  fontWeight: FontWeight.normal,
  color: Colors.grey,
);
TextStyle bodyTextSmaller = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 12,
  fontWeight: FontWeight.w300,
  color: Colors.black,
);
TextStyle bodySmall = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 12,
  fontWeight: FontWeight.w300,
  color: Colors.black,
);
TextStyle displayTitle = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

TextStyle textBolder = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 16,
  fontWeight: FontWeight.w700,
  color: Colors.black,
);

TextStyle boldText = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 18,
  fontWeight: FontWeight.w700,
  color: Colors.black,
);
TextStyle bold = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 16,
  fontWeight: FontWeight.w700,
  color: Colors.black,
);

TextStyle normalText = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 12,
  color: Colors.black,
);
TextStyle m_title = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
TextStyle mytitle = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
TextStyle buttonText = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: primaryDarkColor,
);

TextStyle displaySmallBoldLightGrey = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 10,
  fontWeight: FontWeight.bold,
  color: Colors.black.withOpacity(0.4),
);
TextStyle displaySmall = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 10,
  fontWeight: FontWeight.normal,
  color: Colors.black.withOpacity(0.4),
);
TextStyle displaySmaller = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 13,
  fontWeight: FontWeight.normal,
  color: Colors.black.withOpacity(0.4),
);
TextStyle displaySmallerLightGrey = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 13,
  fontWeight: FontWeight.w500,
  color: Colors.black.withOpacity(0.4),
);
TextStyle displayGrey = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: Colors.black.withOpacity(0.4),
);
TextStyle greyText = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.black.withOpacity(0.4),
);
TextStyle greytext = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 14,
  fontWeight: FontWeight.normal,
  color: Colors.black.withOpacity(0.4),
);

TextStyle displayBigBoldBlack = GoogleFonts.getFont(
  Strings.fontName,
  fontSize: 25,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
