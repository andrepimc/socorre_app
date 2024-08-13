import 'package:flutter/material.dart';
import 'package:socorre_app/theme/my_app_colors.dart';

class MyAppThemes {
  static final lightTheme = ThemeData(
    primaryColor: MyAppColors.lightBlue,
    brightness: Brightness.light,
  );

  static final darkTheme = ThemeData(
    primaryColor: MyAppColors.darkMainGreen,
    brightness: Brightness.dark,
  );
}