import 'package:flutter/material.dart';
import 'package:movies_asd/core/constants/app_colors.dart';

final _borderLight = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: AppColors.borderGrey!, width: 2, style: BorderStyle.solid));

final _borderDark = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: AppColors.grey, width: 2, style: BorderStyle.solid));

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xFFF8F8F8),
  canvasColor: AppColors.white,
  secondaryHeaderColor: AppColors.grey,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: TextTheme(bodyMedium: TextStyle(color: AppColors.dark)),
  inputDecorationTheme: InputDecorationTheme(
    border: _borderLight,
    enabledBorder: _borderLight,
    focusedBorder: _borderLight,
    labelStyle: TextStyle(color: AppColors.purple),
  ),
  iconTheme: IconThemeData(color: AppColors.grey),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.pinkAccent,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 3, // Add depth
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.dark,
  secondaryHeaderColor: AppColors.white,
  canvasColor: AppColors.grey,
  appBarTheme: AppBarTheme(backgroundColor: AppColors.dark, elevation: 2),
  textTheme: TextTheme(bodyMedium: TextStyle(color: AppColors.white)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.dark,
    selectedItemColor: Colors.pinkAccent,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: _borderDark,
    enabledBorder: _borderDark,
    focusedBorder: _borderDark,
    fillColor: AppColors.grey,
    labelStyle: TextStyle(color: AppColors.white),
    filled: true,
  ),
  iconTheme: IconThemeData(color: AppColors.white),
  cardTheme: CardTheme(
    color: AppColors.grey,
    elevation: 3, // Add depth
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);
