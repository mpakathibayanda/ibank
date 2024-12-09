import 'package:flutter/material.dart';
import 'package:ibank/core/customs/pallete.dart';

final appThemeData = ThemeData.light().copyWith(
  scaffoldBackgroundColor: Pallete.primary,
  appBarTheme: const AppBarTheme(
    backgroundColor: Pallete.primary,
    scrolledUnderElevation: 0,
    elevation: 0,
    iconTheme: IconThemeData(color: Pallete.white),
    actionsIconTheme: IconThemeData(color: Pallete.white),
  ),
  iconTheme: const IconThemeData(color: Pallete.white),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(
        color: Pallete.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      textStyle: const TextStyle(color: Pallete.white),
      minimumSize: const Size(100, 50),
      maximumSize: const Size(double.infinity, 50),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Pallete.strongBlue,
      textStyle: const TextStyle(color: Pallete.white),
      minimumSize: const Size(100, 50),
      maximumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
);
