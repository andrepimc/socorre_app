import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socorre_app/theme/my_app_colors.dart';

class MyAppTextStyles {
  static TextStyle appBarTitle = GoogleFonts.poppins(
    fontSize: 16,
    color: MyAppColors.darkMainText,
    fontWeight: FontWeight.w500,
  );
  static TextStyle homeBold = GoogleFonts.fascinateInline(
    fontSize: 36,
    color: MyAppColors.darkMainText,
    fontWeight: FontWeight.w400,
  );
  static TextStyle homeNormal = GoogleFonts.poppins(
    fontSize: 16,
    color: MyAppColors.darkSecondaryText,
    fontWeight: FontWeight.w400,
  );
  static TextStyle loginBold = GoogleFonts.poppins(
    fontSize: 14,
    color: MyAppColors.darkSecondaryText,
    letterSpacing: .5,
    fontWeight: FontWeight.w700,
  );
  static TextStyle loginNormal = GoogleFonts.poppins(
    fontSize: 14,
    color: MyAppColors.darkMainText,
    fontWeight: FontWeight.w500,
  );
  static TextStyle loginLight = GoogleFonts.poppins(
    fontSize: 12,
    color: MyAppColors.darkSecondaryText,
    fontWeight: FontWeight.w600,
  );
  static TextStyle homeCardLabel = GoogleFonts.poppins(
    fontSize: 14,
    color: MyAppColors.darkMainText,
    fontWeight: FontWeight.w500,
  );
  static TextStyle alertTitle = GoogleFonts.fascinateInline(
    fontSize: 24,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );
  static TextStyle alertOptions = GoogleFonts.poppins(
    fontSize: 14,
    color: MyAppColors.darkMainText,
    fontWeight: FontWeight.w500,
  );
  static TextStyle button = GoogleFonts.fascinateInline(
    fontSize: 24,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );
  static TextStyle textInput = GoogleFonts.poppins(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );

  static TextStyle adressCardBold = GoogleFonts.poppins(
    fontSize: 16,
    color: MyAppColors.darkSecondaryText,
    letterSpacing: .5,
    fontWeight: FontWeight.w700,
  );
  static TextStyle adressCardNormal = GoogleFonts.poppins(
    fontSize: 14,
    color: MyAppColors.darkMainText,
    fontWeight: FontWeight.w500,
  );
  static TextStyle adressCardLight = GoogleFonts.poppins(
    fontSize: 12,
    color: MyAppColors.darkSecondaryText,
    fontWeight: FontWeight.w400,
  );
  static TextStyle orderh1 = GoogleFonts.poppins(
    fontSize: 24,
    color: MyAppColors.darkSecondaryText,
    fontWeight: FontWeight.w700,
  );
  static TextStyle orderh2 = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
  static TextStyle orderh3 = GoogleFonts.poppins(
      fontSize: 14,
      color: MyAppColors.darkSecondaryText,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.underline);
}
