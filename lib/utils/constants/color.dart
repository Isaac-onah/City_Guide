import 'package:flutter/material.dart';

Color kDarkColor = const Color(0xFF000000);
Color klightedOrange = const Color(0xFFFF1515);
Color kFormBColor = const Color(0xFF1E1E1E);
Color kwhiteBackground =  const Color(0xFFFAFAFA);
Color kashcolor =  const Color(0xFFD9D9D9);
Color iconcolor =  const Color(0xFF9C9C9C);
Color inputBorder = const Color(0xFFAFAFAF);
Color linecurve = const Color(0xFF302F2F).withOpacity(0.5);


class TColors{
  TColors._();

  //App Basic Colors
  static const Color primary = Color (0xff0ACF83);

  static const Color secondary = Color (0xFFFFE24B);

  static const Color accent = Color (0xFFb0c7ff);

  static const Color card = Color (0xFF034956);

  //Gradient Colors

  static const Gradient linerGradient = LinearGradient(
      begin: Alignment(0.0, 0.0),
      end: Alignment(0.707,-0.707),
      colors: [
      Color(0xff0ACF83),
      Color(0xff85E7C1),
      ]
  ); // LinearGradient

// Text Colors

  static const Color textPrimary = Color (0xFF333333);

  static const Color textSecondary = Color (0xFF6C757D);

  static const Color textWhite = Colors.white;

// Background Colors

  static const Color light = Color (0xFFF6F6F6);

  static const Color dark = Color (0xFF272727);

  static const Color primaryBackground = Color (0xFFF3F5FF);

  // Background Container Colors I

  static const Color lightContainer = Color (0xFFF6F6F6);

  static Color darkContainer = TColors.white.withOpacity(0.1);

// Button Colors

  static const Color buttonPrimary = Color (0xff0ACF83);

  static const Color buttonSecondary = Color (0xFF6C757D);

  static const Color buttonDisabled = Color (0xFFC4C4C4);

// Border Colors

  static const Color borderPrimary = Color (0xFFD9D9D9);

  static const Color borderSecondary = Color (0xFFE6E6E6);

// Error and Validation Colors

  static const Color error = Color (0xFFD32F2F);

  static const Color success = Color (0xFF388E3C);

  static const Color warning = Color (0xFFF57000);

  static const Color info = Color (0xFF1976D2);
  // Neutral Shades

  static const Color black = Color (0xFF232323);

  static const Color darkerGrey = Color (0xFF4F4F4F);

  static const Color darkGrey = Color(0xFF939393);

  static const Color grey = Color (0xFFD4D4D4);

  static const Color softGrey = Color (0xFFF4F4F4);

  static const Color lightGrey = Color (0xFFF9F9F9);

  static const Color white = Color (0xFFFFFFFF);
}
